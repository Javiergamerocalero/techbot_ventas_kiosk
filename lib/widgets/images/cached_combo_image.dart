import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/images/image_cache_provider.dart';

/// Widget optimizado para mostrar imágenes de combos con caché robusto
class CachedComboImage extends ConsumerWidget {
  final Combo combo;
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

  const CachedComboImage({
    super.key,
    required this.combo,
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

      // Obtener la URL de la imagen del combo (con caché para evitar rebuilds)
      final cacheKey = '${combo.id}_$baseUrl';
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
        // Multiplicar por 4 para máxima calidad en cards de combos
        memCacheWidth = (width! * 4).toInt();
      }
      if (height != null && height!.isFinite && height! > 0) {
        // Multiplicar por 4 para máxima calidad en cards de combos
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
            print('❌ CachedComboImage: Error cargando imagen: $error');
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
      print('❌ CachedComboImage: Error crítico: $e');
      return _buildPlaceholder(d, colorScheme);
    }
  }

  /// Obtiene la URL de la imagen del combo con caché
  String? _getImageUrl(String baseUrl, imageCacheService) {
    // Crear clave única para el combo
    final cacheKey = '${combo.id}_${combo.images.length}_${combo.thumbnail}';
    
    // Verificar caché primero
    if (_urlCache.containsKey(cacheKey)) {
      return _urlCache[cacheKey];
    }
    
    String? resultUrl;
    
    // Prioridad: primera imagen del array ordenada por priority, luego thumbnail
    if (combo.images.isNotEmpty) {
      try {
        // Usar el método de extensión que ya ordena por prioridad
        final primaryImage = combo.primaryImage;
        if (primaryImage != null) {
          final partialUrl = primaryImage['url'] as String?;
          if (partialUrl != null && partialUrl.isNotEmpty) {
            resultUrl = imageCacheService.buildImageUrl(partialUrl, baseUrl);
          }
        }
      } catch (e) {
        // Solo log de errores críticos
        print('⚠️ CachedComboImage: Error procesando imágenes combo ${combo.id}: $e');
      }
    }
    
    // Fallback a thumbnail si existe
    if (resultUrl == null && combo.thumbnail.isNotEmpty) {
      resultUrl = imageCacheService.buildImageUrl(combo.thumbnail, baseUrl);
    }
    
    // Guardar en caché
    _urlCache[cacheKey] = resultUrl;
    
    // Log solo la primera vez y solo en debug
    if (resultUrl == null && const bool.fromEnvironment('dart.vm.product') == false) {
      print('🖼️ CachedComboImage: No hay imágenes disponibles para combo ${combo.id}');
    }
    
    return resultUrl;
  }

  /// Widget placeholder cuando no hay imagen disponible
  Widget _buildPlaceholder(d, ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: borderRadius,
      ),
      child: Icon(
        Icons.restaurant_menu_outlined,
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
