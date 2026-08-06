import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/services/image_cache_service.dart';

part 'image_cache_provider.g.dart';

/// Provider para el servicio de caché de imágenes
@Riverpod(keepAlive: true)
ImageCacheService imageCacheService(Ref ref) {
  final service = ImageCacheService();
  service.initialize();
  return service;
}

/// Provider para obtener la URL base del servidor
@Riverpod(keepAlive: true)
String baseUrl(Ref ref) {
  final appEnv = dotenv.get('APP_ENV');
  final url = appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: 'DEV_URL not found')
      : dotenv.get('PROD_URL', fallback: 'PROD_URL not found');
  return url;
}
