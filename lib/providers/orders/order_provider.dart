import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/services/order_service.dart';

part 'order_provider.g.dart';

/// Función helper para obtener la URL base
String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: 'API_URL not found')
      : dotenv.get('PROD_URL', fallback: 'API_URL not found');
}

/// Provider para el servicio de órdenes.
@Riverpod(keepAlive: true)
OrderService orderService(Ref ref) {
  return OrderService(baseUrl: _getBaseUrl());
}

/// Provider para procesar una orden.
@riverpod
Future<OrderResponse> processOrder(
  Ref ref,
  double finalAmount,
  String? couponCode,
  Map<String, dynamic>? paymentData,
) async {
  final service = ref.read(orderServiceProvider);
  return service.processOrder(
    finalAmount: finalAmount,
    couponCode: couponCode,
    paymentData: paymentData,
  );
}
