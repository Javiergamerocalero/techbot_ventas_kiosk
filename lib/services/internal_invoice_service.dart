import 'dart:convert';
import 'package:ventas_kiosko/services/app_log.dart';
import 'package:http/http.dart' as http;

/// Servicio para manejar facturas internas (reserva y finalización)
class InternalInvoiceService {
  final String baseUrl;
  final String token;

  InternalInvoiceService({
    required this.baseUrl,
    required this.token,
  });

  /// Reserva un número de correlativo para la factura
  /// 
  /// POST /api/invoices/reserve
  /// Body: { "order_id": int, "license_id": int, "document_type": string }
  
  Future<Map<String, dynamic>> reserveInvoiceNumber({
    required int orderId,
    required int licenseId,
    required String documentType, // "boleta" o "factura"
  }) async {
    try {
      print('📝 Reservando correlativo para order $orderId ($documentType)');
      
      final requestBody = {
        'order_id': orderId,
        'license_id': licenseId,
        'document_type': documentType,
      };

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/invoices/reserve'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              print('⏰ TIMEOUT: El servidor no respondió en 15 segundos');
              throw InternalInvoiceException(
                'Timeout: El servidor no respondió en 15 segundos',
              );
            },
          );

      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'reservar correlativo',
        request: requestBody,
        response: response.body,
        ok: response.statusCode == 200 || response.statusCode == 201,
        detalle: 'HTTP ${response.statusCode}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (!responseData.containsKey('data')) {
          throw InternalInvoiceException('Respuesta inválida: falta campo "data"');
        }

        final data = responseData['data'] as Map<String, dynamic>;

        if (!data.containsKey('invoice_number') || !data.containsKey('formatted_number')) {
          throw InternalInvoiceException(
            'Respuesta inválida: faltan campos requeridos (invoice_number, formatted_number)',
          );
        }

        print('✅ Correlativo reservado: ${data['formatted_number']}');
        return responseData;
      } else {
        try {
          final errorJson = jsonDecode(response.body) as Map<String, dynamic>;
          final errorMessage = errorJson['message'] as String? ?? 
                              errorJson['error'] as String? ?? 
                              'Error ${response.statusCode}';
          throw InternalInvoiceException(errorMessage);
        } catch (e) {
          if (e is InternalInvoiceException) rethrow;
          throw InternalInvoiceException('Error ${response.statusCode}: ${response.body}');
        }
      }
    } on InternalInvoiceException {
      rethrow;
    } catch (e) {
      if (e is InternalInvoiceException) rethrow;
      throw InternalInvoiceException('Error al reservar correlativo: $e');
    }
  }

  /// Finaliza la factura guardando la respuesta del API externo
  /// 
  /// PATCH /api/invoices/finalize
  /// Body: { "invoice_id": int, "license_id": int, "invoice_data": Map }
  
  Future<Map<String, dynamic>> finalizeInvoice({
    required int invoiceId,
    required int licenseId,
    required Map<String, dynamic> invoiceData,
  }) async {
    print('✅ Finalizando factura $invoiceId');

    try {
      final requestBody = {
        'invoice_id': invoiceId,
        'license_id': licenseId,
        'invoice_data': invoiceData,
      };

      final response = await http
          .patch(
            Uri.parse('$baseUrl/api/invoices/finalize'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw InternalInvoiceException(
                'Timeout: El servidor no respondió en 15 segundos',
              );
            },
          );

      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'finalizar comprobante',
        request: requestBody,
        response: response.body,
        ok: response.statusCode == 200 || response.statusCode == 201,
        detalle: 'HTTP ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        print('✅ Factura finalizada');
        return responseData;
      } else {
        throw InternalInvoiceException(
          'Error al finalizar factura (${response.statusCode}): ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } on InternalInvoiceException {
      rethrow;
    } catch (e) {
      throw InternalInvoiceException(
        'Error de conexión al finalizar factura: ${e.toString()}',
      );
    }
  }

  /// Cancela/rollback de una factura reservada (para futuro endpoint)
  /// 
  /// DELETE /api/invoices/{invoiceId}/cancel
  /// 
  /// NOTA: Endpoint aún no disponible, preparado para implementación futura
  Future<void> cancelInvoice({
    required int invoiceId,
    required int licenseId,
    String? reason,
  }) async {
    print('🔄 Cancelando factura $invoiceId: ${reason ?? "Error en proceso"}');
    print('⚠️ Endpoint de cancelación aún no disponible');
  }
}

/// Excepción personalizada para errores de facturación interna
class InternalInvoiceException implements Exception {
  final String message;
  final int? statusCode;

  InternalInvoiceException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
