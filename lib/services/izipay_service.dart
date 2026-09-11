import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Cliente del PinPad Izipay P400 vía PMP-API REST (spec v2.3, 2023).
///
/// El servicio corre en un dispositivo Windows separado en la LAN
/// (referido en el spec como "Servidor de despliegue") y expone:
///
///  - `POST /login`               → devuelve JWT (HS256).
///  - `POST /test`                → chequea disponibilidad (Bearer).
///  - `POST /procesarTransaccion` → compra/anulación/reportes.
///
/// La URL base se arma desde la config guardada en SharedPreferences
/// (`izipay_ip`, `izipay_port`, `izipay_user`, `izipay_password`,
/// `izipay_with_bin`). Estos valores se editan en Config → Izipay.
///
/// Flow "Con BIN" (2 requests) — activado por config `izipay_with_bin`:
///
///  1. POST /procesarTransaccion con `ecr_data_adicional3: "1"` →
///     el pinpad devuelve el BIN de la tarjeta (`card`) pero NO
///     procesa la compra.
///  2. POST /procesarTransaccion sin `ecr_data_adicional3` (mismo
///     monto/moneda) → procesa la compra real. Timeout máximo 120s
///     entre ambos requests según el spec.
///
///  Si el user cancela después del paso 1, el paso 2 se manda con
///  `ecr_data_adicional3: "9"` para que el pinpad libere el estado.
class IzipayService {
  static const _boxTimeoutSeconds = 30;

  // Prefs keys — misma familia que las de niubiz para consistencia.
  static const kPrefIp = 'izipay_ip';
  static const kPrefPort = 'izipay_port';
  static const kPrefUser = 'izipay_user';
  static const kPrefPassword = 'izipay_password';
  static const kPrefWithBin = 'izipay_with_bin';

  static const _defaultPort = '9090';
  static const _defaultUser = 'izipay';
  static const _defaultPassword = 'izipay';
  static const _txCompra = '01';
  static const _txDuplicado = '03';
  static const _txReporteDetallado = '04';
  static const _txReporteTotales = '05';
  static const _txAnulacion = '06';
  static const _txCierre = '07';
  static const _moneySoles = '604';

  String? _cachedToken;

  Future<IzipayConfigSnapshot> _readConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final ip = (prefs.getString(kPrefIp) ?? '').trim();
    final port = (prefs.getString(kPrefPort) ?? _defaultPort).trim();
    final user = (prefs.getString(kPrefUser) ?? _defaultUser).trim();
    final password =
        (prefs.getString(kPrefPassword) ?? _defaultPassword).trim();
    final withBin = prefs.getBool(kPrefWithBin) ?? false;
    return IzipayConfigSnapshot(
      ip: ip,
      port: port,
      user: user,
      password: password,
      withBin: withBin,
    );
  }

  Uri _url(IzipayConfigSnapshot cfg, String path) =>
      Uri.parse('http://${cfg.ip}:${cfg.port}/API_PPAD/$path');

  /// Convierte `12.34` (soles) a `"1234"` (formato ecr_amount).
  static String amountToEcr(double amount) {
    final cents = (amount * 100).round();
    if (cents < 0) throw ArgumentError('amount must be non-negative');
    // El spec dice "los 2 últimos dígitos son los decimales" — mínimo
    // 3 caracteres ("010" = 0.10, "120" = 1.20).
    return cents.toString().padLeft(3, '0');
  }

  Future<String> _login(IzipayConfigSnapshot cfg) async {
    final resp = await http.post(
      _url(cfg, 'login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ecr_usuario': cfg.user, 'ecr_password': cfg.password}),
    ).timeout(const Duration(seconds: _boxTimeoutSeconds));

    if (resp.statusCode != 200) {
      throw IzipayException(
        'Login rechazado (HTTP ${resp.statusCode}): ${resp.body}',
      );
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    if (data['resultado'] != '00' || data['token'] is! String) {
      throw IzipayException(
        'Login rechazado: ${data['message'] ?? data['resultado']}',
      );
    }
    return data['token'] as String;
  }

  Future<String> _getToken(IzipayConfigSnapshot cfg,
      {bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedToken != null) return _cachedToken!;
    _cachedToken = await _login(cfg);
    return _cachedToken!;
  }

  Future<Map<String, dynamic>> _postWithAuth(
    IzipayConfigSnapshot cfg,
    String path,
    Map<String, dynamic> body, {
    Duration? timeout,
  }) async {
    Future<http.Response> doPost(String token) => http
        .post(
          _url(cfg, path),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        )
        .timeout(timeout ?? const Duration(seconds: _boxTimeoutSeconds));

    var token = await _getToken(cfg);
    var resp = await doPost(token);

    // Token expirado / inválido → reintento con login nuevo.
    if (resp.statusCode == 401 || resp.statusCode == 403) {
      token = await _getToken(cfg, forceRefresh: true);
      resp = await doPost(token);
    }
    if (resp.statusCode >= 400) {
      throw IzipayException('HTTP ${resp.statusCode}: ${resp.body}');
    }
    final decoded = jsonDecode(resp.body);
    if (decoded is! Map<String, dynamic>) {
      throw IzipayException('Respuesta inesperada del pinpad');
    }
    return decoded;
  }

  /// Test de disponibilidad del pinpad (`POST /test`). Devuelve `true`
  /// si `response_code == "00"`.
  Future<bool> test() async {
    final cfg = await _readConfig();
    if (cfg.ip.isEmpty) return false;
    try {
      final data = await _postWithAuth(cfg, 'test', const {});
      return data['response_code'] == '00';
    } catch (_) {
      return false;
    }
  }

  /// Compra estándar. Si la config tiene `withBin: true`, primero
  /// solicita BIN (`ecr_data_adicional3=1`), lo entrega vía
  /// [onBinReceived] y después dispara la compra final. Si
  /// [onBinReceived] devuelve `false`, se envía cancelación
  /// (`ecr_data_adicional3=9`) y la compra NO se realiza.
  ///
  /// Devuelve el JSON completo de la respuesta final del pinpad
  /// (incluye `print_data`, `card`, `approval_code`, etc.).
  Future<IzipayPurchaseResult> purchase({
    required double amount,
    Future<bool> Function(String bin)? onBinReceived,
  }) async {
    final cfg = await _readConfig();
    if (cfg.ip.isEmpty) {
      throw IzipayException('IP del pinpad Izipay no configurada');
    }
    final ecrAmount = amountToEcr(amount);
    final baseBody = {
      'ecr_aplicacion': 'POS',
      'ecr_transaccion': _txCompra,
      'ecr_amount': ecrAmount,
      'ecr_currency_code': _moneySoles,
    };

    if (cfg.withBin) {
      // Paso 1: solicitar BIN.
      final binResp = await _postWithAuth(cfg, 'procesarTransaccion', {
        ...baseBody,
        'ecr_data_adicional3': '1',
      });
      if (binResp['response_code'] != '00') {
        throw IzipayException(
          'Rechazo al solicitar BIN: ${binResp['message'] ?? binResp['response_code']}',
        );
      }
      final bin = (binResp['card'] ?? '').toString();

      // Confirmación del cliente / caja.
      final proceed = onBinReceived == null
          ? true
          : await onBinReceived(bin);
      if (!proceed) {
        // Cancelación explícita del flow con BIN.
        await _postWithAuth(cfg, 'procesarTransaccion', {
          ...baseBody,
          'ecr_data_adicional3': '9',
        }).catchError((_) => <String, dynamic>{});
        throw IzipayException('Compra cancelada tras solicitud de BIN');
      }
    }

    // Paso final (o único, si no hay BIN): compra real. Timeout
    // largo — el pinpad puede tardar mientras el usuario inserta la
    // tarjeta y digita el PIN.
    final finalResp = await _postWithAuth(
      cfg,
      'procesarTransaccion',
      baseBody,
      timeout: const Duration(seconds: 120),
    );

    final rc = finalResp['response_code']?.toString() ?? '';
    if (rc != '00') {
      throw IzipayException(
        finalResp['message']?.toString().trim().isNotEmpty == true
            ? finalResp['message'].toString().trim()
            : 'Compra rechazada (response_code=$rc)',
      );
    }
    return IzipayPurchaseResult.fromResponse(finalResp);
  }

  /// Anulación por número de referencia. Requiere la referencia
  /// devuelta en la compra original (`trace_number` / campo REF del
  /// voucher).
  Future<IzipayPurchaseResult> voidPurchase({
    required double amount,
    required String reference,
  }) async {
    final cfg = await _readConfig();
    if (cfg.ip.isEmpty) {
      throw IzipayException('IP del pinpad Izipay no configurada');
    }
    final resp = await _postWithAuth(
      cfg,
      'procesarTransaccion',
      {
        'ecr_aplicacion': 'POS',
        'ecr_transaccion': _txAnulacion,
        'ecr_amount': amountToEcr(amount),
        'ecr_currency_code': _moneySoles,
        'ecr_data_adicional': reference,
      },
      timeout: const Duration(seconds: 60),
    );
    final rc = resp['response_code']?.toString() ?? '';
    if (rc != '00') {
      throw IzipayException(
        'Anulación rechazada: ${resp['message'] ?? rc}',
      );
    }
    return IzipayPurchaseResult.fromResponse(resp);
  }

  /// Duplicado del último voucher (ecr_transaccion 03).
  Future<IzipayPurchaseResult> duplicateLast() =>
      _supervisorTx(_txDuplicado, timeout: const Duration(seconds: 60));

  /// Reporte detallado del lote (ecr_transaccion 04).
  Future<IzipayPurchaseResult> detailedReport() =>
      _supervisorTx(_txReporteDetallado, timeout: const Duration(seconds: 90));

  /// Reporte de totales del lote (ecr_transaccion 05).
  Future<IzipayPurchaseResult> totalsReport() =>
      _supervisorTx(_txReporteTotales, timeout: const Duration(seconds: 90));

  /// Cierre de turno / lote (ecr_transaccion 07).
  Future<IzipayPurchaseResult> closeShift() =>
      _supervisorTx(_txCierre, timeout: const Duration(seconds: 90));

  Future<IzipayPurchaseResult> _supervisorTx(
    String tx, {
    Map<String, dynamic> extra = const {},
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final cfg = await _readConfig();
    if (cfg.ip.isEmpty) {
      throw IzipayException('IP del pinpad Izipay no configurada');
    }
    final resp = await _postWithAuth(
      cfg,
      'procesarTransaccion',
      {
        'ecr_aplicacion': 'POS',
        'ecr_transaccion': tx,
        ...extra,
      },
      timeout: timeout,
    );
    final rc = resp['response_code']?.toString() ?? '';
    final printData = resp['print_data']?.toString() ?? '';
    if (rc != '00' && printData.trim().isEmpty) {
      throw IzipayException(
        resp['message']?.toString().trim().isNotEmpty == true
            ? resp['message'].toString().trim()
            : 'Operación rechazada (response_code=$rc)',
      );
    }
    return IzipayPurchaseResult.fromResponse(resp);
  }
}

/// Snapshot inmutable de la config leída de SharedPreferences.
class IzipayConfigSnapshot {
  const IzipayConfigSnapshot({
    required this.ip,
    required this.port,
    required this.user,
    required this.password,
    required this.withBin,
  });

  final String ip;
  final String port;
  final String user;
  final String password;
  final bool withBin;
}

/// Resultado de una compra/anulación exitosa (`response_code == "00"`).
class IzipayPurchaseResult {
  const IzipayPurchaseResult({
    required this.printData,
    required this.approvalCode,
    required this.card,
    required this.amount,
    required this.currencyCode,
    required this.message,
    required this.raw,
    this.traceNumber,
    this.batchNumber,
    this.terminalNumber,
    this.cardId,
  });

  final String printData;
  final String approvalCode;
  final String card;
  final String amount;
  final String currencyCode;
  final String message;
  final Map<String, dynamic> raw;
  final String? traceNumber;
  final String? batchNumber;
  final String? terminalNumber;
  final String? cardId;

  factory IzipayPurchaseResult.fromResponse(Map<String, dynamic> body) {
    String s(dynamic v) => v?.toString() ?? '';
    return IzipayPurchaseResult(
      printData: s(body['print_data']),
      approvalCode: s(body['approval_code']),
      card: s(body['card']),
      amount: s(body['amount']),
      currencyCode: s(body['currency_code']),
      message: s(body['message']).trim(),
      traceNumber: body['trace_number']?.toString(),
      batchNumber: body['batch_number']?.toString(),
      terminalNumber: body['terminal_number']?.toString(),
      cardId: body['card_id']?.toString(),
      raw: body,
    );
  }
}

/// Excepción específica del cliente Izipay — permite diferenciar
/// errores del pinpad (rechazos de compra, timeouts, config faltante)
/// de errores genéricos de red.
class IzipayException implements Exception {
  const IzipayException(this.message);
  final String message;

  @override
  String toString() => 'IzipayException: $message';
}
