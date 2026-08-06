import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/coupon/coupon.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Servicio para validar cupones de descuento.
class CouponService {
  final String baseUrl;
  final Ref ref;

  CouponService({required this.baseUrl, required this.ref});

  /// Valida un cupón de descuento.
  /// 
  /// Llama al endpoint: POST /api/coupon/validate
  /// 
  Future<CouponValidationResponse> validateCoupon({
    required String couponCode,
    required double purchaseAmount,
  }) async {
    try {
      final licenseAsync = ref.read(licenseProvider);
      final tenantId = licenseAsync.when(
        data: (license) => license.tenantId,
        loading: () => 1,
        error: (_, __) => 1,
      );
      
      print('🎫 CouponService: Validando cupón para tenant: $tenantId');
      
      final url = Uri.parse('$baseUrl/api/coupon/validate');
      
      final requestBody = {
        "tenant_id": tenantId,
        "coupon_code": couponCode,
        "purchase_amount": purchaseAmount.toString(),
      };
      
      print('🎫 CouponService: Request body: $requestBody');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Timeout: El servidor no respondió');
        },
      );
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        return CouponValidationResponse.fromJson(responseData);
      } else if (response.statusCode == 422) {
        // Error de validación - cupón inválido
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final message = responseData['message'] as String? ?? 'Cupón no válido';
        throw CouponValidationException(message);
      } else {
        throw Exception('Error del servidor (${response.statusCode})');
      }
      
    } catch (e) {
      if (e is CouponValidationException) {
        rethrow; 
      }
      throw Exception('Error de conexión: $e');
    }
  }
}

class CouponValidationException implements Exception {
  final String message;
  
  CouponValidationException(this.message);
  
  @override
  String toString() => message;
}
