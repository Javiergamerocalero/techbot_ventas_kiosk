import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/models/config/license_data.dart';

/// Servicio para procesar órdenes de compra.
class OrderService {
  final String baseUrl;

  OrderService({required this.baseUrl});

  /// Obtiene el ID de la licencia activa desde SharedPreferences
  Future<int> _getLicenseId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('licenseData');

      print('🔍 OrderService: JSON de licencia obtenido: ${jsonString != null ? "SÍ" : "NO"}');

      if (jsonString != null) {
        print('🔍 OrderService: JSON completo de licencia: $jsonString');
        final jsonMap = jsonDecode(jsonString);
        print('🔍 OrderService: JSON decodificado: $jsonMap');

        final licenseData = LicenseData.fromJson(jsonMap);
        print('🔍 OrderService: LicenseData creado - id: ${licenseData.id}, tenantId: ${licenseData.tenantId}');

        if (licenseData.id > 0) {
          print('✅ OrderService: Usando license ID: ${licenseData.id} (tenant_id: ${licenseData.tenantId})');
          return licenseData.id;
        } else {
          print('⚠️ OrderService: License ID inválido (${licenseData.id}), esperado > 0');
        }
      } else {
        print('⚠️ OrderService: No hay datos de licencia en SharedPreferences');
      }

      print('⚠️ OrderService: No se encontró license ID válido en licencia, usando fallback: 1');
      return 1; // Fallback por compatibilidad
    } catch (e) {
      print('❌ OrderService: Error obteniendo license ID: $e, usando fallback: 1');
      return 1; // Fallback en caso de error
    }
  }

  /// Procesa una orden de compra.
  ///
  /// Llama al endpoint: POST /api/order/store
  /// Body: { "license_id": [id_from_license], "coupon_code": code?, "final_amount": amount, "payment_data": data? }
  ///
  Future<OrderResponse> processOrder({
    required double finalAmount,
    String? couponCode,
    Map<String, dynamic>? paymentData,
  }) async {
    try {
      // Obtener el license_id real desde SharedPreferences
      final licenseId = await _getLicenseId();
      print('🛒 OrderService: Usando license_id: $licenseId para crear orden');

      final url = Uri.parse('$baseUrl/api/order/store');

      final requestBody = <String, dynamic>{"license_id": licenseId, "final_amount": finalAmount};

      // Solo agregar coupon_code si existe
      if (couponCode != null && couponCode.isNotEmpty) {
        requestBody["coupon_code"] = couponCode;
      }

      // Add payment transaction data if provided
      if (paymentData != null) {
        requestBody["payment_data"] = paymentData;
      }

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
              'Accept': 'application/json',
            },
            body: json.encode(requestBody),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('Timeout: El servidor no respondió');
            },
          );

      print('🛒 OrderService: Response status: ${response.statusCode}');
      print('🛒 OrderService: Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        return OrderResponse.fromJson(responseData);
      } else {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final message = responseData['message'] as String? ?? 'Error al procesar la orden';
        throw OrderProcessingException(message);
      }
    } catch (e) {
      if (e is OrderProcessingException) {
        rethrow;
      }
      print('❌ OrderService: Error de conexión: $e');
      throw Exception('Error de conexión: $e');
    }
  }
}

class OrderResponse {
  final bool success;
  final String message;
  final int? orderId;
  final String? orderNumber;
  final Map<String, dynamic>? additionalData;

  OrderResponse({required this.success, required this.message, this.orderId, this.orderNumber, this.additionalData});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String? ?? 'Orden procesada exitosamente',
      orderId: json['order_id'] as int?,
      orderNumber: json['order_number'] as String?,
      additionalData: json,
    );
  }
}

class OrderProcessingException implements Exception {
  final String message;

  OrderProcessingException(this.message);

  @override
  String toString() => message;
}
