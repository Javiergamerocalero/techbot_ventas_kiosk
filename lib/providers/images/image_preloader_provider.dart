import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/providers/images/image_cache_provider.dart';

part 'image_preloader_provider.g.dart';

/// Provider para precargar imágenes de productos en background
@Riverpod(keepAlive: true)
class ImagePreloader extends _$ImagePreloader {
  @override
  Future<void> build() async {
  }

  /// Precarga las imágenes de una lista de productos en background
  Future<void> preloadProductImages(List<Product> products) async {
    if (products.isEmpty) return;
    
    final imageCacheService = ref.read(imageCacheServiceProvider);
    final baseUrl = ref.read(baseUrlProvider);
    
    print('📥 ImagePreloader: Iniciando precarga de ${products.length} productos');
    
    // Priorizar productos por importancia
    final prioritizedProducts = _prioritizeProducts(products);
    
    // 1. Procesar productos destacados primero (alta prioridad)
    if (prioritizedProducts['featured']?.isNotEmpty == true) {
      print('⭐ ImagePreloader: Precargando productos destacados...');
      const featuredBatchSize = 3;
      final featuredProducts = prioritizedProducts['featured']!;
      
      for (int i = 0; i < featuredProducts.length; i += featuredBatchSize) {
        final batch = featuredProducts.skip(i).take(featuredBatchSize).toList();
        
        await Future.wait(
          batch.map((product) async {
            try {
              final imageUrl = product.getMainImageUrl(baseUrl);
              if (imageUrl != null) {
                await imageCacheService.precacheImage(imageUrl);
              }
            } catch (e) {
              // Error silencioso para no interferir con la precarga
            }
          }),
        );
        
        // Pausa mínima entre lotes de destacados
        if (i + featuredBatchSize < featuredProducts.length) {
          await Future.delayed(const Duration(milliseconds: 50));
        }
      }
    }
    
    // 2. Procesar productos regulares (prioridad normal)
    if (prioritizedProducts['regular']?.isNotEmpty == true) {
      print('📦 ImagePreloader: Precargando productos regulares...');
      const regularBatchSize = 5;
      final regularProducts = prioritizedProducts['regular']!;
      
      for (int i = 0; i < regularProducts.length; i += regularBatchSize) {
        final batch = regularProducts.skip(i).take(regularBatchSize).toList();
        
        await Future.wait(
          batch.map((product) async {
            try {
              final imageUrl = product.getMainImageUrl(baseUrl);
              if (imageUrl != null) {
                await imageCacheService.precacheImage(imageUrl);
              }
            } catch (e) {
              // Error silencioso para no interferir con la precarga
            }
          }),
        );
        
        // Pausa más larga entre lotes regulares
        if (i + regularBatchSize < regularProducts.length) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
      }
    }
    
  }

  /// Prioriza productos por importancia para optimizar la precarga
  Map<String, List<Product>> _prioritizeProducts(List<Product> products) {
    final featured = <Product>[];
    final regular = <Product>[];
    
    for (final product in products) {
      if (product.isFavorite == true) {
        featured.add(product);
      } else {
        regular.add(product);
      }
    }
    
    // Ordenar destacados por ID (los más recientes primero)
    featured.sort((a, b) => b.id.compareTo(a.id));
    
    // Ordenar regulares por ID
    regular.sort((a, b) => b.id.compareTo(a.id));
    
    return {
      'featured': featured,
      'regular': regular,
    };
  }

  /// Precarga una imagen específica
  Future<void> preloadSingleImage(Product product) async {
    final imageCacheService = ref.read(imageCacheServiceProvider);
    final baseUrl = ref.read(baseUrlProvider);
    
    try {
      final imageUrl = product.getMainImageUrl(baseUrl);
      if (imageUrl != null) {
        await imageCacheService.precacheImage(imageUrl);
      }
    } catch (e) {
      //
    }
  }

  /// Precarga las imágenes de combos con priorización
  Future<void> preloadComboImages(List<Combo> combos) async {
    if (combos.isEmpty) return;
    
    final imageCacheService = ref.read(imageCacheServiceProvider);
    final baseUrl = ref.read(baseUrlProvider);
    
    print('📥 ImagePreloader: Iniciando precarga de ${combos.length} combos');
    
    // Procesar combos en lotes más pequeños (son menos que productos)
    const batchSize = 4;
    for (int i = 0; i < combos.length; i += batchSize) {
      final batch = combos.skip(i).take(batchSize).toList();
      await Future.wait(
        batch.map((combo) async {
          try {
            if (combo.images.isNotEmpty) {
              final primaryImage = combo.primaryImage;
              if (primaryImage != null) {
                final partialUrl = primaryImage['url'] as String?;
                if (partialUrl != null && partialUrl.isNotEmpty) {
                  final fullUrl = imageCacheService.buildImageUrl(partialUrl, baseUrl);
                  await imageCacheService.precacheImage(fullUrl);
                }
              }
              
              // Opcionalmente precargar imágenes adicionales para carousel (solo las primeras 3)
              final sortedImages = combo.sortedImages;
              for (int imgIndex = 1; imgIndex < sortedImages.length && imgIndex < 3; imgIndex++) {
                final imageData = sortedImages[imgIndex];
                final partialUrl = imageData['url'] as String?;
                if (partialUrl != null && partialUrl.isNotEmpty) {
                  final fullUrl = imageCacheService.buildImageUrl(partialUrl, baseUrl);
                  await imageCacheService.precacheImage(fullUrl);
                }
              }
            } else if (combo.thumbnail.isNotEmpty) {
              // Fallback a thumbnail si no hay imágenes en el array
              final fullUrl = imageCacheService.buildImageUrl(combo.thumbnail, baseUrl);
              await imageCacheService.precacheImage(fullUrl);
            }
          } catch (e) {
            // Error silencioso para no interferir con la precarga
          }
        }),
      );
      
      if (i + batchSize < combos.length) {
        await Future.delayed(const Duration(milliseconds: 150));
      }
    }
    
    
    // Precargar las imágenes de los productos dentro de los combos
    await _preloadComboProductImages(combos);
  }

  /// Precarga las imágenes de los productos que están dentro de los combos
  Future<void> _preloadComboProductImages(List<Combo> combos) async {
    final imageCacheService = ref.read(imageCacheServiceProvider);
    final baseUrl = ref.read(baseUrlProvider);
    
    final Set<int> processedProductIds = {};
    final List<Product> comboProducts = [];
    
    for (final combo in combos) {
      for (final product in combo.products) {
        if (!processedProductIds.contains(product.id)) {
          processedProductIds.add(product.id);
          comboProducts.add(product);
        }
      }
    }
    
    if (comboProducts.isEmpty) return;
        
    // Procesar productos de combos en lotes pequeños
    const batchSize = 3;
    for (int i = 0; i < comboProducts.length; i += batchSize) {
      final batch = comboProducts.skip(i).take(batchSize).toList();
      await Future.wait(
        batch.map((product) async {
          try {
            final imageUrl = product.getMainImageUrl(baseUrl);
            if (imageUrl != null && imageUrl.isNotEmpty) {
              await imageCacheService.precacheImage(imageUrl);
            }
          } catch (e) {
            // Error silencioso para no interferir con la precarga
          }
        }),
      );
      
      // Pausa entre lotes para no interferir con la UX
      if (i + batchSize < comboProducts.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    
  }
}
