import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Servicio para gestionar el caché de imágenes de productos de manera robusta.
class ImageCacheService {
  static final _instance = ImageCacheService._internal();
  factory ImageCacheService() => _instance;
  ImageCacheService._internal();

  // Configuración de caché personalizada
  static const String _cacheKey = 'product_images_cache';
  late final CacheManager _cacheManager;

  /// Inicializa el servicio de caché con configuración optimizada para kiosko
  void initialize() {
    _cacheManager = CacheManager(
      Config(
        _cacheKey,
        stalePeriod: const Duration(days: 30),   // Caché válido por 30 días (optimizado para kiosko)
        maxNrOfCacheObjects: 2000,               // Máximo 2000 imágenes (mayor capacidad)
        repo: JsonCacheInfoRepository(databaseName: _cacheKey),
        fileService: HttpFileService(),
      ),
    );
    print('🖼️ ImageCacheService: Inicializado con caché de 30 días y máximo 2000 imágenes (optimizado para kiosko)');
  }

  /// Construye la URL completa de una imagen
  String buildImageUrl(String partialUrl, String baseUrl) {
    if (partialUrl.startsWith('http')) {
      return partialUrl;
    }
    
    // Asegurar que baseUrl no termine con / y partialUrl no empiece con /
    final cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    final cleanPartialUrl = partialUrl.startsWith('/') ? partialUrl : '/$partialUrl';
    
    final fullUrl = '$cleanBaseUrl$cleanPartialUrl';
    // Solo log en debug para evitar spam en consola
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      print('🔗 ImageCacheService: URL construida: $fullUrl');
    }
    return fullUrl;
  }

  /// Precarga una imagen en el caché sin mostrarla
  Future<void> precacheImage(String imageUrl) async {
    try {
      print('⬇️ ImageCacheService: Precargando imagen: $imageUrl');
      await _cacheManager.downloadFile(imageUrl);
      print('✅ ImageCacheService: Imagen precargada exitosamente');
    } catch (e) {
      print('⚠️ ImageCacheService: Error precargando imagen: $e');
    }
  }

  /// Verifica si una imagen está en caché
  Future<bool> isImageCached(String imageUrl) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(imageUrl);
      return fileInfo != null;
    } catch (e) {
      print('⚠️ ImageCacheService: Error verificando caché: $e');
      return false;
    }
  }

  /// Limpia el caché de imágenes (usar con precaución)
  Future<void> clearCache() async {
    try {
      await _cacheManager.emptyCache();
      print('🗑️ ImageCacheService: Caché limpiado exitosamente');
    } catch (e) {
      print('⚠️ ImageCacheService: Error limpiando caché: $e');
    }
  }

  /// Obtiene información del caché
  Future<Map<String, dynamic>> getCacheInfo() async {
    try {
      return {
        'cache_key': _cacheKey,
        'max_objects': 2000,
        'stale_period_days': 30,
        'optimization': 'kiosko_optimized',
        'is_initialized': true,
      };
    } catch (e) {
      return {
        'cache_key': _cacheKey,
        'error': e.toString(),
        'is_initialized': false,
      };
    }
  }

  /// Getter para acceder al CacheManager desde widgets
  CacheManager get cacheManager => _cacheManager;
}
