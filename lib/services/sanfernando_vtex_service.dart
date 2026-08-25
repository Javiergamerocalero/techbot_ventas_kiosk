/// Integración con la API VTEX de San Fernando.
///
/// Reporta cada venta aprobada del kiosco al backend de San Fernando
/// vía `POST https://integracionvtexqas.san-fernando.com.pe/api/v1/order`.
///
/// **Estado 2026-08-25**: implementación completa pero FEATURE-FLAG OFF.
/// SF todavía no entregó `client_id`, `client_secret` ni `scope` de la
/// app registrada en Azure Entra ID (tenant
/// `bc0a31cc-1943-4dea-9a34-02e0fca59160`), y el presupuesto de
/// integración no está aprobado aún. Cuando lleguen las creds:
///   1. Cargarlas en el `.env` del kiosco (SANFERNANDO_VTEX_*).
///   2. Poner `SANFERNANDO_VTEX_ENABLED=true`.
///   3. Rebuild + reinstalar APK.
///
/// Doc del endpoint: Diccionario_APIVTEX.xlsx enviado por Javier
/// 2026-08-25 16:38 (jgamero@techbotperu.com).
///
/// Swagger: https://integracionvtexqas.san-fernando.com.pe/api/docs/
///
/// Decisiones de mapeo (a validar con SF cuando aprueben la
/// integración — dejadas en constantes al tope para tocar rápido):
///
/// - `code_niubiz` = `orderId` numérico devuelto por Qapp al hacer el
///   `POST /api/orders`. Único por venta, integer, ya disponible en
///   el kiosco post-checkout. No hay ninguna referencia a "niubiz"
///   real acá — el campo se llama así por legado del sistema SF.
///
/// - `type_cart` = `"pt"` (confirmado por Javier 2026-08-25).
///
/// - `delivery_type` = 4 (Recojo). No hay delivery en el kiosco
///   presencial.
///
/// - `deliver_date` / `deliver_hour` = fecha/hora actual del kiosco
///   (la venta se retira inmediatamente).
///
/// - `payment_method_code`:
///   - 1 = En línea (tarjeta débito/crédito) — no aplica al kiosco.
///   - 2 = En POS (tarjeta) — IziPay / cualquier PinPad.
///   - 3 = En Efectivo — Cashdro / cash manual.
///
/// - `products[].sap_code` = SKU del producto Qapp (confirmado por
///   Javier 2026-08-25).
///
/// - `products[].product_type` = `"product"` (constante — el kiosco
///   no maneja servicios).
///
/// - `user.email` / `user.phone_number`: NO los tenemos en la base
///   del validador. Se envían placeholders (cadena vacía). Si SF los
///   requiere no-vacíos, hay que ampliar el Excel del validador con
///   esas columnas.
///
/// - `address` / `in_charge`: no tenemos dirección de entrega en el
///   kiosco. Se envían con valores de la planta SF (configurables en
///   .env: SANFERNANDO_ADDRESS_*, defaults para el kiosco San
///   Fernando San Isidro Lima). `in_charge` = mismo empleado.
///
/// - `invoice.social_reason`: vacío cuando es boleta. Cuando el
///   kiosco emite factura, viene del comprobante.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Contexto de la venta que se reporta. Se arma en
/// [buildOrderContextFromCart] o manualmente en el caller.
class SanFernandoOrderContext {
  /// `orderId` numérico devuelto por Qapp — va como `code_niubiz`.
  final int orderId;

  /// Total final cobrado al cliente (con IGV, descuentos aplicados).
  final double total;

  /// Total antes de aplicar cupones. Si no hubo cupón, == total.
  final double totalBeforeCoupon;

  /// Subtotal sin IGV.
  final double subtotal;

  /// IGV (18% del subtotal).
  final double igv;

  /// Ahorro por cupón. 0 si no hubo.
  final double couponSaved;

  /// Datos del empleado que hizo la compra (viene del validador SF).
  final SanFernandoEmployeeSnapshot employee;

  /// Items de la venta.
  final List<SanFernandoProductLine> products;

  /// Cupones aplicados. `[]` si no hubo.
  final List<SanFernandoCoupon> coupons;

  /// Método de pago usado.
  final SanFernandoPaymentMethod paymentMethod;

  /// Monto de efectivo entregado (aplica solo a pago en efectivo).
  final int? paymentMethodCash;

  /// Datos del comprobante emitido (boleta/factura).
  final SanFernandoInvoiceInfo invoice;

  const SanFernandoOrderContext({
    required this.orderId,
    required this.total,
    required this.totalBeforeCoupon,
    required this.subtotal,
    required this.igv,
    required this.couponSaved,
    required this.employee,
    required this.products,
    required this.coupons,
    required this.paymentMethod,
    this.paymentMethodCash,
    required this.invoice,
  });
}

class SanFernandoEmployeeSnapshot {
  final String firstName;
  final String lastName;
  final String documentNumber;
  final SanFernandoDocumentType documentType;

  /// Placeholders — el validador de empleados no guarda estos hoy. Si
  /// SF los pide no-vacíos, ampliar el schema del validator con
  /// columnas `email` y `phone` en el Excel.
  final String email;
  final String phoneNumber;

  const SanFernandoEmployeeSnapshot({
    required this.firstName,
    required this.lastName,
    required this.documentNumber,
    this.documentType = SanFernandoDocumentType.dni,
    this.email = '',
    this.phoneNumber = '',
  });
}

class SanFernandoProductLine {
  final String name;
  final String sapCode; // SKU del producto Qapp
  final double priceUnit;
  final double referencePrice;
  final double subtotal;
  final int quantity;
  final double? weight;

  const SanFernandoProductLine({
    required this.name,
    required this.sapCode,
    required this.priceUnit,
    required this.referencePrice,
    required this.subtotal,
    required this.quantity,
    this.weight,
  });
}

class SanFernandoCoupon {
  final int id;
  final String name;
  final SanFernandoDiscountType typeDiscount;
  final SanFernandoCouponCategory type;
  final double amountDiscount;
  final double discount;

  const SanFernandoCoupon({
    required this.id,
    required this.name,
    required this.typeDiscount,
    required this.type,
    required this.amountDiscount,
    required this.discount,
  });
}

class SanFernandoInvoiceInfo {
  /// `'boleta'` o `'factura'`. En minúsculas.
  final String type;
  final String documentNumber;
  final String? socialReason; // vacío en boletas
  final String? address; // opcional, usa placeholder si null

  const SanFernandoInvoiceInfo({
    required this.type,
    required this.documentNumber,
    this.socialReason,
    this.address,
  });
}

enum SanFernandoDocumentType {
  dni(1),
  ruc(6),
  ce(3),
  passport(7);

  final int code;
  const SanFernandoDocumentType(this.code);
}

enum SanFernandoPaymentMethod {
  onlineCard(1, 'En línea (Tarjeta de crédito/débito)'),
  posCard(2, 'En POS (Tarjeta de crédito/débito)'),
  cash(3, 'En Efectivo');

  final int code;
  final String label;
  const SanFernandoPaymentMethod(this.code, this.label);
}

enum SanFernandoDiscountType {
  percentage('percentage'),
  fixed('fixed');

  final String value;
  const SanFernandoDiscountType(this.value);
}

enum SanFernandoCouponCategory {
  cupon('C'),
  giftcard('G');

  final String value;
  const SanFernandoCouponCategory(this.value);
}

/// Resultado del envío del reporte de venta.
class SanFernandoReportResult {
  final bool success;
  final int? statusCode;
  final String? message;
  final int? cartId;
  final String? error;

  /// `true` si el server respondió 409 "ya importado" — desde nuestro
  /// lado lo tratamos como éxito idempotente.
  final bool alreadyReported;

  const SanFernandoReportResult({
    required this.success,
    this.statusCode,
    this.message,
    this.cartId,
    this.error,
    this.alreadyReported = false,
  });

  factory SanFernandoReportResult.disabled() =>
      const SanFernandoReportResult(
        success: false,
        error: 'SanFernando VTEX disabled (feature flag)',
      );

  factory SanFernandoReportResult.missingCreds() =>
      const SanFernandoReportResult(
        success: false,
        error: 'Credenciales OAuth no configuradas en .env',
      );
}

class SanFernandoVtexService {
  /// Feature flag. Si es `false`, [reportOrder] devuelve inmediato
  /// sin hacer ninguna request. Default `false` hasta que SF entregue
  /// credenciales y aprueben la integración.
  static bool get enabled =>
      _envBool('SANFERNANDO_VTEX_ENABLED', defaultValue: false);

  /// URL base del backend VTEX (sin `/api/v1`). Default QAS.
  static String get baseUrl => dotenv.get(
        'SANFERNANDO_VTEX_BASE_URL',
        fallback: 'https://integracionvtexqas.san-fernando.com.pe',
      );

  /// Tenant Azure (documentado en el swagger).
  static String get azureTenantId => dotenv.get(
        'SANFERNANDO_AZURE_TENANT_ID',
        fallback: 'bc0a31cc-1943-4dea-9a34-02e0fca59160',
      );

  static String get clientId =>
      dotenv.get('SANFERNANDO_VTEX_CLIENT_ID', fallback: '');
  static String get clientSecret =>
      dotenv.get('SANFERNANDO_VTEX_CLIENT_SECRET', fallback: '');
  static String get scope =>
      dotenv.get('SANFERNANDO_VTEX_SCOPE', fallback: '');

  // ── Cache de token OAuth ──────────────────────────────────────────
  static String? _cachedToken;
  static DateTime? _cachedTokenExpiresAt;

  /// Obtiene un access_token vía Client Credentials. Cachea el token
  /// hasta 60s antes de su expiración para minimizar calls.
  static Future<String?> _getAccessToken(http.Client client) async {
    final now = DateTime.now();
    if (_cachedToken != null &&
        _cachedTokenExpiresAt != null &&
        _cachedTokenExpiresAt!.isAfter(now.add(const Duration(seconds: 60)))) {
      return _cachedToken;
    }

    final id = clientId;
    final secret = clientSecret;
    final sc = scope;
    if (id.isEmpty || secret.isEmpty || sc.isEmpty) {
      return null;
    }

    final tokenUri = Uri.parse(
      'https://login.microsoftonline.com/$azureTenantId/oauth2/v2.0/token',
    );
    final res = await client.post(
      tokenUri,
      headers: {
        HttpHeaders.contentTypeHeader:
            'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': id,
        'client_secret': secret,
        'grant_type': 'client_credentials',
        'scope': sc,
      },
    );
    if (res.statusCode != 200) {
      // ignore: avoid_print
      print(
        '⚠️ SF VTEX token request failed: '
        'HTTP ${res.statusCode} — ${res.body}',
      );
      return null;
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final token = json['access_token'] as String?;
    final expiresIn = (json['expires_in'] as num?)?.toInt() ?? 3600;
    if (token == null) return null;
    _cachedToken = token;
    _cachedTokenExpiresAt = now.add(Duration(seconds: expiresIn));
    return token;
  }

  /// Reporta una venta aprobada al backend SF. NO lanza excepciones —
  /// captura todo internamente y devuelve un [SanFernandoReportResult].
  /// El caller decide si loguea el error o reintenta.
  ///
  /// Idempotencia: HTTP 409 "Pedido ya importado" se trata como éxito
  /// silencioso (`alreadyReported=true`, `success=true`) para que un
  /// retry desde el kiosco no falle si el server ya lo tenía.
  static Future<SanFernandoReportResult> reportOrder(
    SanFernandoOrderContext ctx,
  ) async {
    if (!enabled) {
      return SanFernandoReportResult.disabled();
    }
    final client = http.Client();
    try {
      final token = await _getAccessToken(client);
      if (token == null) {
        return SanFernandoReportResult.missingCreds();
      }

      final body = _buildPayload(ctx);
      final uri = Uri.parse('$baseUrl/api/v1/order');
      final res = await client
          .post(
            uri,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      if (res.statusCode == 409) {
        return SanFernandoReportResult(
          success: true,
          statusCode: 409,
          message: 'Ya reportado previamente',
          alreadyReported: true,
        );
      }
      if (res.statusCode < 200 || res.statusCode >= 300) {
        return SanFernandoReportResult(
          success: false,
          statusCode: res.statusCode,
          error: res.body.isNotEmpty ? res.body : 'HTTP ${res.statusCode}',
        );
      }
      Map<String, dynamic>? decoded;
      try {
        decoded = jsonDecode(res.body) as Map<String, dynamic>;
      } catch (_) {
        decoded = null;
      }
      return SanFernandoReportResult(
        success: true,
        statusCode: res.statusCode,
        message: decoded?['message']?.toString(),
        cartId: (decoded?['cart_id'] as num?)?.toInt(),
      );
    } catch (e) {
      return SanFernandoReportResult(
        success: false,
        error: e.toString(),
      );
    } finally {
      client.close();
    }
  }

  static Map<String, dynamic> _buildPayload(SanFernandoOrderContext ctx) {
    final now = DateTime.now();
    final dateStr = _fmtDateTime(now);
    final deliverDate = _fmtDate(now);
    final deliverHour = _fmtTime(now);

    final addressFallback = _defaultAddress();
    final invoiceAddress = ctx.invoice.address ?? addressFallback['address']!;

    return {
      'code_niubiz': ctx.orderId,
      'date': dateStr,
      'delivery_type': _deliveryTypePickup,
      'delivery_price': 0,
      'type_cart': _typeCartPt,
      'deliver_date': deliverDate,
      'deliver_hour': deliverHour,
      'total_before_coupon': _round2(ctx.totalBeforeCoupon),
      'total': _round2(ctx.total),
      'coupon_saved': _round2(ctx.couponSaved),
      'subtotal': _round2(ctx.subtotal),
      'igv': _round2(ctx.igv),
      'payment_method_name': ctx.paymentMethod.label,
      'payment_method_code': ctx.paymentMethod.code,
      'payment_method_cash': ctx.paymentMethodCash,
      'user': {
        'first_name': ctx.employee.firstName,
        'last_name': ctx.employee.lastName,
        'email': ctx.employee.email,
        'document_number': ctx.employee.documentNumber,
        'phone_number': ctx.employee.phoneNumber,
        'document_type_code': ctx.employee.documentType.code,
      },
      'address': addressFallback,
      'in_charge': {
        'first_name': ctx.employee.firstName,
        'last_name': ctx.employee.lastName,
        'phone_number': ctx.employee.phoneNumber,
      },
      'products': ctx.products
          .map(
            (p) => {
              'name': p.name,
              'product_type': 'product',
              'price_unit': _round2(p.priceUnit),
              'reference_price': _round2(p.referencePrice),
              'subtotal': _round2(p.subtotal),
              'sap_code': p.sapCode,
              'quantity': p.quantity,
              if (p.weight != null) 'weight': _round2(p.weight!),
            },
          )
          .toList(),
      'coupons': ctx.coupons
          .map(
            (c) => {
              'id': c.id,
              'name': c.name,
              'type_discount': c.typeDiscount.value,
              'type': c.type.value,
              'amount_discount': _round2(c.amountDiscount),
              'discount': _round2(c.discount),
            },
          )
          .toList(),
      'invoice': {
        'social_reason': ctx.invoice.socialReason ?? '',
        'address': invoiceAddress,
        'type': ctx.invoice.type.toLowerCase(),
        'document_number': ctx.invoice.documentNumber,
      },
    };
  }

  /// Dirección default (planta / kiosco SF). Editable en .env por si
  /// hay varios kioscos con distintas direcciones o ubigeos.
  static Map<String, String> _defaultAddress() => {
        'address': dotenv.get(
          'SANFERNANDO_ADDRESS',
          fallback: 'Av. República de Panamá 3535, San Isidro',
        ),
        'reference': dotenv.get(
          'SANFERNANDO_ADDRESS_REFERENCE',
          fallback: 'Kiosco San Fernando',
        ),
        'lat': dotenv.get(
          'SANFERNANDO_ADDRESS_LAT',
          fallback: '-12.0964',
        ),
        'lng': dotenv.get(
          'SANFERNANDO_ADDRESS_LNG',
          fallback: '-77.0264',
        ),
        'ubigeo_code': dotenv.get(
          'SANFERNANDO_ADDRESS_UBIGEO',
          fallback: '150131',
        ),
      };

  static bool _envBool(String key, {required bool defaultValue}) {
    try {
      final raw = dotenv.get(key, fallback: '').trim().toLowerCase();
      if (raw.isEmpty) return defaultValue;
      return raw == 'true' || raw == '1' || raw == 'yes';
    } catch (_) {
      return defaultValue;
    }
  }

  static String _fmtDateTime(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final hh = d.hour.toString().padLeft(2, '0');
    final mi = d.minute.toString().padLeft(2, '0');
    final ss = d.second.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year} $hh:$mi:$ss';
  }

  static String _fmtDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  static String _fmtTime(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mi = d.minute.toString().padLeft(2, '0');
    return '$hh:$mi';
  }

  static double _round2(double v) => (v * 100).roundToDouble() / 100;

  // Constantes decididas 2026-08-25 (Javier). Ver docstring top.
  static const int _deliveryTypePickup = 4;
  static const String _typeCartPt = 'pt';
}
