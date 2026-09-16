import 'dart:convert';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/services/app_log.dart';

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
  // Códigos de operación segun la tabla de `ecr_transaccion` de las
  // Especificaciones Tecnicas PMP-API REST v2.3, pagina 7. Son publicos
  // para que las pruebas afirmen sobre ellos.
  static const txCompra = '01';
  static const txAnulacion = '06';
  static const txReporteDetallado = '09';
  static const txReporteTotales = '10';
  static const txReimpresion = '11';
  static const txCierre = '12';
  static const txReporteDetalladoCierre = '19';
  static const txReporteTotalesCierre = '20';
  static const txQrDirecto = '67';
  static const _moneySoles = '604';
  static const _appId = 'POS';

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

  /// Headers mínimos absolutos — matcheando el Postman de Javier
  /// que responde 200 con solo Content-Type + body JSON. Sin
  /// User-Agent custom, sin Accept, sin Cache-Control — dejamos que
  /// Dart mande sus defaults naturales para que el resultado sea el
  /// "cliente simple" más parecido a Postman.
  Map<String, String> _headers({String? bearer}) => {
        'Content-Type': 'application/json',
        if (bearer != null) 'Authorization': 'Bearer $bearer',
      };

  /// Cuerpo de una compra. Con [IzipayMode.tarjeta] es la transaccion
  /// `01` del manual (4.3). Con [IzipayMode.qr] es la `67`, "Compra Pago
  /// con QR Directo" (8.2), que ademas lleva `ecr_data_adicional` en "0"
  /// para indicarle al pinpad que NO pida BIN: el manual dice que esta
  /// transaccion no debe ir precedida de una consulta de BIN.
  @visibleForTesting
  static Map<String, dynamic> purchaseBody(
    double amount, {
    IzipayMode mode = IzipayMode.tarjeta,
  }) {
    final body = <String, dynamic>{
      'ecr_aplicacion': _appId,
      'ecr_transaccion': mode == IzipayMode.qr ? txQrDirecto : txCompra,
      'ecr_amount': amountToEcr(amount),
      'ecr_currency_code': _moneySoles,
    };
    if (mode == IzipayMode.qr) {
      body['ecr_data_adicional'] = '0';
    }
    return body;
  }

  /// Cuerpo de una anulación (`06`): además del monto, la referencia de
  /// la compra original.
  @visibleForTesting
  static Map<String, dynamic> voidBody({
    required double amount,
    required String reference,
  }) => {
        'ecr_aplicacion': _appId,
        'ecr_transaccion': txAnulacion,
        'ecr_amount': amountToEcr(amount),
        'ecr_currency_code': _moneySoles,
        'ecr_data_adicional': reference,
      };

  /// Cuerpo de las operaciones de supervisor.
  ///
  /// El manual es taxativo y minimalista aca: el reporte detallado (4.6),
  /// el de totales (4.7) y el cierre (4.8) viajan **solo** con aplicacion
  /// y transaccion. No llevan moneda ni monto. Mandarles campos de mas es
  /// lo que hacia que el pinpad devolviera el codigo 89.
  ///
  /// La reimpresion (4.5) es la unica que lleva `ecr_data_adicional`, con
  /// el numero de referencia del voucher a reimprimir; si no se indica
  /// referencia el campo se omite y el pinpad reimprime el ultimo.
  @visibleForTesting
  static Map<String, dynamic> supervisorBody(String tx, {String? reference}) {
    final body = <String, dynamic>{
      'ecr_aplicacion': _appId,
      'ecr_transaccion': tx,
    };
    final ref = reference?.trim() ?? '';
    if (tx == txReimpresion && ref.isNotEmpty) {
      body['ecr_data_adicional'] = ref;
    }
    return body;
  }

  Future<String> _login(IzipayConfigSnapshot cfg) async {
    final bodyStr = jsonEncode(
      {'ecr_usuario': cfg.user, 'ecr_password': cfg.password},
    );
    final url = _url(cfg, 'login');
    final headers = _headers();

    // Usamos http.post() plano (no Request explícito) para que Dart
    // maneje Content-Length y todos los defaults como cualquier
    // cliente HTTP normal. En r4 forzamos Content-Length manual y
    // sigue fallando → NO era el chunked encoding.
    final reloj = Stopwatch()..start();
    final http.Response resp;
    try {
      resp = await http
          .post(url, headers: headers, body: bodyStr)
          .timeout(const Duration(seconds: _boxTimeoutSeconds));
    } catch (e) {
      AppLog.registrar(
        categoria: AppLogCategoria.izipay,
        operacion: 'login',
        request: {'url': url.toString(), 'ecr_usuario': cfg.user},
        ok: false,
        detalle: 'no se pudo conectar: $e',
        duracion: reloj.elapsed,
      );
      rethrow;
    }
    AppLog.registrar(
      categoria: AppLogCategoria.izipay,
      operacion: 'login',
      request: {'url': url.toString(), 'ecr_usuario': cfg.user},
      response: {'http': resp.statusCode, 'body': resp.body},
      ok: resp.statusCode == 200,
      duracion: reloj.elapsed,
    );

    if (resp.statusCode != 200) {
      // Diagnóstico completo: URL exacta + headers exactos que
      // enviamos + response completo. Con esto podemos comparar 1:1
      // con lo que manda Postman.
      throw IzipayException(
        'Login rechazado (HTTP ${resp.statusCode}).\n\n'
        'URL: $url\n'
        'Request headers: $headers\n'
        'Request body: $bodyStr\n\n'
        'Response headers: ${resp.headers}\n'
        'Response body: ${resp.body}',
      );
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    if (data['resultado'] != '00' || data['token'] is! String) {
      // El pinpad responde 'mensaje' (no 'message') — verificado en
      // el response OK de Postman de Javier 2026-08-06.
      throw IzipayException(
        'Login rechazado: ${data['mensaje'] ?? data['message'] ?? data['resultado']}',
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
          headers: _headers(bearer: token),
          body: jsonEncode(body),
        )
        .timeout(timeout ?? const Duration(seconds: _boxTimeoutSeconds));

    // La operación se nombra por su código de transacción, que es lo que
    // hay que cruzar contra el manual cuando algo falla.
    final operacion = body['ecr_transaccion'] == null
        ? path
        : '$path ${body['ecr_transaccion']}';
    final reloj = Stopwatch()..start();

    http.Response resp;
    try {
      var token = await _getToken(cfg);
      resp = await doPost(token);

      // Token expirado / inválido → reintento con login nuevo.
      if (resp.statusCode == 401 || resp.statusCode == 403) {
        token = await _getToken(cfg, forceRefresh: true);
        resp = await doPost(token);
      }
    } catch (e) {
      AppLog.registrar(
        categoria: AppLogCategoria.izipay,
        operacion: operacion,
        request: body,
        ok: false,
        detalle: 'no hubo respuesta: $e',
        duracion: reloj.elapsed,
      );
      rethrow;
    }

    final decodificada = _intentarDecodificar(resp.body);
    final codigo = decodificada?['response_code']?.toString();
    AppLog.registrar(
      categoria: AppLogCategoria.izipay,
      operacion: operacion,
      request: body,
      response: decodificada ?? resp.body,
      ok: resp.statusCode < 400 && (codigo == null || codigo == '00'),
      detalle: 'HTTP ${resp.statusCode}'
          '${codigo != null ? ' · código $codigo' : ''}'
          '${decodificada?['message'] != null ? ' · ${decodificada!['message']}' : ''}',
      duracion: reloj.elapsed,
    );

    if (resp.statusCode >= 400) {
      throw IzipayException('HTTP ${resp.statusCode}: ${resp.body}');
    }
    if (decodificada == null) {
      throw IzipayException('Respuesta inesperada del pinpad');
    }
    return decodificada;
  }

  static Map<String, dynamic>? _intentarDecodificar(String cuerpo) {
    try {
      final d = jsonDecode(cuerpo);
      return d is Map<String, dynamic> ? d : null;
    } catch (_) {
      return null;
    }
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
    IzipayMode mode = IzipayMode.tarjeta,
    Future<bool> Function(String bin)? onBinReceived,
  }) async {
    final cfg = await _readConfig();
    if (cfg.ip.isEmpty) {
      throw IzipayException('IP del pinpad Izipay no configurada');
    }
    final baseBody = purchaseBody(amount, mode: mode);

    // El QR directo no admite consulta de BIN previa (manual, 8.2), asi
    // que el paso del BIN se salta aunque la config lo tenga activado.
    if (cfg.withBin && mode == IzipayMode.tarjeta) {
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
      voidBody(amount: amount, reference: reference),
      timeout: const Duration(seconds: 60),
    );
    final rc = resp['response_code']?.toString() ?? '';
    if (rc != '00') {
      final msg = resp['message']?.toString().trim() ?? '';
      throw IzipayException(
        'Anulación rechazada: ${msg.isNotEmpty ? msg : 'sin mensaje'} (código $rc)',
      );
    }
    return IzipayPurchaseResult.fromResponse(resp);
  }

  /// Duplicado (reimpresión) del último voucher. Si [reference] viene
  /// vacío el pinpad reimprime la última operación del lote.
  Future<IzipayPurchaseResult> duplicateLast({String reference = ''}) =>
      _supervisorTx(
        txReimpresion,
        reference: reference,
        timeout: const Duration(seconds: 60),
      );

  /// Reporte detallado del lote.
  Future<IzipayPurchaseResult> detailedReport() => _supervisorTx(
        txReporteDetallado,
        timeout: const Duration(seconds: 90),
      );

  /// Reporte de totales del lote.
  Future<IzipayPurchaseResult> totalsReport() => _supervisorTx(
        txReporteTotales,
        timeout: const Duration(seconds: 90),
      );

  /// Cierre de turno / lote. No admite deshacer.
  ///
  /// El manual (4.8) no deja cerrar a secas: la caja debe mandar primero
  /// el reporte detallado de cierre (`19`), despues el de totales (`20`)
  /// y solo entonces el cierre (`12`), cortando la secuencia si alguno no
  /// aprueba. Devuelve los tres vouchers concatenados para que el
  /// operador los tenga completos.
  Future<IzipayPurchaseResult> closeShift() async {
    const paso = Duration(seconds: 90);
    final detalle = await _supervisorTx(txReporteDetalladoCierre, timeout: paso);
    final totales = await _supervisorTx(txReporteTotalesCierre, timeout: paso);
    final cierre = await _supervisorTx(txCierre, timeout: paso);
    return cierre.withPrependedVouchers([detalle, totales]);
  }

  Future<IzipayPurchaseResult> _supervisorTx(
    String tx, {
    String? reference,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final cfg = await _readConfig();
    if (cfg.ip.isEmpty) {
      throw IzipayException('IP del pinpad Izipay no configurada');
    }
    final resp = await _postWithAuth(
      cfg,
      'procesarTransaccion',
      supervisorBody(tx, reference: reference),
      timeout: timeout,
    );
    final rc = resp['response_code']?.toString() ?? '';
    final printData = resp['print_data']?.toString() ?? '';
    if (rc != '00' && printData.trim().isEmpty) {
      final msg = resp['message']?.toString().trim() ?? '';
      throw IzipayException(
        msg.isNotEmpty ? '$msg (código $rc)' : 'Operación rechazada (código $rc)',
      );
    }
    return IzipayPurchaseResult.fromResponse(resp);
  }
}

/// Como se cobra en el pinpad: leyendo la tarjeta o mostrando un QR.
/// Son dos transacciones distintas de la PMP-API (`01` y `67`), no dos
/// caminos de la misma.
enum IzipayMode {
  tarjeta,
  qr;

  String get displayName => this == IzipayMode.qr ? 'QR' : 'Tarjeta';
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

  /// Devuelve el mismo resultado con los vouchers de [previos] delante
  /// del propio. Lo usa el cierre de lote, que son tres transacciones
  /// pero un solo comprobante para el operador.
  IzipayPurchaseResult withPrependedVouchers(
    List<IzipayPurchaseResult> previos,
  ) {
    final partes = [
      ...previos.map((r) => r.printData),
      printData,
    ].where((p) => p.trim().isNotEmpty);
    return IzipayPurchaseResult(
      printData: partes.join('\r'),
      approvalCode: approvalCode,
      card: card,
      amount: amount,
      currencyCode: currencyCode,
      message: message,
      raw: raw,
      traceNumber: traceNumber,
      batchNumber: batchNumber,
      terminalNumber: terminalNumber,
      cardId: cardId,
    );
  }

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
