import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/images/image_cache_provider.dart';

/// Widget optimizado para mostrar imágenes de productos con caché robusto
class CachedProductImage extends ConsumerWidget {
  final Product product;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  // Caché estático de URLs para evitar reconstrucción constante
  static final Map<String, String?> _urlCache = <String, String?>{};
  
  /// Limpia el caché de URLs (útil cuando cambia la configuración)
  static void clearUrlCache() {
    _urlCache.clear();
  }

  const CachedProductImage({
    super.key,
    required this.product,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    
    try {
      final imageCacheService = ref.watch(imageCacheServiceProvider);
      final baseUrl = ref.watch(baseUrlProvider);

      // Obtener la URL de la imagen principal (con caché para evitar rebuilds)
      final cacheKey = '${product.id}_$baseUrl';
      String? imageUrl = _urlCache[cacheKey];
      
      if (imageUrl == null) {
        imageUrl = _getImageUrl(baseUrl, imageCacheService);
        _urlCache[cacheKey] = imageUrl;
      }
      
      if (imageUrl == null) {
        return _buildPlaceholder(d, colorScheme);
      }

      // Calcular dimensiones optimizadas para memCache con mejor calidad
      int? memCacheWidth;
      int? memCacheHeight;
      
      if (width != null && width!.isFinite && width! > 0) {
        // Multiplicar por 4 para máxima calidad en cards de productos
        memCacheWidth = (width! * 4).toInt();
      }
      if (height != null && height!.isFinite && height! > 0) {
        // Multiplicar por 4 para máxima calidad en cards de productos
        memCacheHeight = (height! * 4).toInt();
      }

      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          cacheManager: imageCacheService.cacheManager,
          placeholder: (context, url) => _buildLoadingPlaceholder(d, colorScheme),
          errorWidget: (context, url, error) {
            print('❌ CachedProductImage: Error cargando imagen: $error');
            return _buildPlaceholder(d, colorScheme);
          },
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 150),
          memCacheWidth: memCacheWidth,
          memCacheHeight: memCacheHeight,
          filterQuality: FilterQuality.high, // Mejor calidad de filtrado
          alignment: Alignment.center,
        ),
      );
    } catch (e) {
      print('❌ CachedProductImage: Error crítico: $e');
      return _buildPlaceholder(d, colorScheme);
    }
  }

  /// Obtiene la URL de la imagen principal del producto
  String? _getImageUrl(String baseUrl, imageCacheService) {
    // Prioridad: primera imagen del array ordenada por priority, luego thumbnail
    if (product.images.isNotEmpty) {
      try {
        // Ordenar imágenes por prioridad (menor número = mayor prioridad)
        final sortedImages = List<Map<String, dynamic>>.from(product.images)
          ..sort((a, b) {
            final priorityA = a['priority'] as int? ?? 999;
            final priorityB = b['priority'] as int? ?? 999;
            return priorityA.compareTo(priorityB);
          });
        
        final firstImage = sortedImages.first;
        final partialUrl = firstImage['url'] as String?;
        
        if (partialUrl != null && partialUrl.isNotEmpty) {
          final fullUrl = imageCacheService.buildImageUrl(partialUrl, baseUrl);
          // Solo log en debug para evitar spam en consola
          if (const bool.fromEnvironment('dart.vm.product') == false) {
            print('🖼️ CachedProductImage: Usando imagen principal: $fullUrl');
          }
          return fullUrl;
        }
      } catch (e) {
        print('⚠️ CachedProductImage: Error procesando imágenes: $e');
      }
    }
    
    // Fallback a thumbnail si existe
    if (product.thumbnail.isNotEmpty) {
      final thumbnailUrl = imageCacheService.buildImageUrl(product.thumbnail, baseUrl);
      // Solo log en debug para evitar spam en consola
      if (const bool.fromEnvironment('dart.vm.product') == false) {
        print('🖼️ CachedProductImage: Usando thumbnail: $thumbnailUrl');
      }
      return thumbnailUrl;
    }
    
    print('🖼️ CachedProductImage: No hay imágenes disponibles para producto ${product.id}');
    return null;
  }

  /// Widget placeholder cuando no hay imagen disponible
  Widget _buildPlaceholder(d, ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: borderRadius,
      ),
      child: Icon(
        Icons.fastfood_outlined,
        size: d.iconSizeM,
        color: colorScheme.onSurface.withValues(alpha: 0.4),
      ),
    );
  }

  /// Widget placeholder durante la carga
  Widget _buildLoadingPlaceholder(d, ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.3),
        borderRadius: borderRadius,
      ),
      child: Center(
        child: SizedBox(
          width: d.iconSizeS,
          height: d.iconSizeS,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colorScheme.primary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
