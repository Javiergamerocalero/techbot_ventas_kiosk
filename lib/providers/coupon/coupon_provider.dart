import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/services/coupon_service.dart';

part 'coupon_provider.g.dart';

String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: ' DEV_URL not found')
      : dotenv.get('PROD_URL', fallback: 'PROD_URL not found');
}

/// Provider para el servicio de cupones.
@Riverpod(keepAlive: true)
CouponService couponService(Ref ref) {
  return CouponService(baseUrl: _getBaseUrl(), ref: ref);
}

