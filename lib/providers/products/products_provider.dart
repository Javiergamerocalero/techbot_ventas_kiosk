import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/services/stock_service.dart';
import 'package:ventas_kiosko/models/products/stock_response.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';
import 'package:ventas_kiosko/providers/images/image_cache_provider.dart';

part 'products_provider.g.dart';

/// Provider para manejar el stock actualizado de productos en tiempo real
final productStockMapProvider = StateProvider<Map<int, int>>((ref) => {});

/// Provider para manejar el stock actualizado de VARIACIONES de productos
/// Key format: "productId_variationId" -> stock
final productVariationStockMapProvider = StateProvider<Map<String, int>>((ref) => {});

/// Helper para actualizar el stock de un producto
void updateProductStockHelper(Ref ref, int productId, int newStock) {
  final currentStock = ref.read(productStockMapProvider);
  ref.read(productStockMapProvider.notifier).state = {
    ...currentStock,
    productId: newStock,
  };
  print('📦 ProductStock: Producto $productId actualizado a stock: $newStock');
}

/// Helper para actualizar el stock de una variación específica
void updateProductVariationStockHelper(Ref ref, int productId, int variationId, int newStock) {
  final key = '${productId}_$variationId';
  final currentStock = ref.read(productVariationStockMapProvider);
  ref.read(productVariationStockMapProvider.notifier).state = {
    ...currentStock,
    key: newStock,
  };
  print('📦 VariationStock: Producto $productId, Variación $variationId actualizado a stock: $newStock');
}

/// Provider para verificar si un producto está sin stock
@riverpod
bool isProductOutOfStock(Ref ref, int productId) {
  final currentStock = ref.watch(currentProductStockProvider(productId));
  return currentStock <= 0;
}

/// Provider para obtener el stock actual de un producto específico
@riverpod
int currentProductStock(Ref ref, int productId) {
  final stockMap = ref.watch(productStockMapProvider);
  
  // Si hay stock actualizado en el mapa, usarlo
  if (stockMap.containsKey(productId)) {
    return stockMap[productId]!;
  }
  
  // Si no hay stock actualizado, buscar el stock original del producto
  final allProductsAsync = ref.watch(allProductsProvider);
  return allProductsAsync.when(
    data: (products) {
      final product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception('Producto no encontrado: $productId'),
      );
      return product.effectiveStock;
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
}

/// Provider para obtener el stock actual de una variación específica
@riverpod
int currentProductVariationStock(Ref ref, int productId, int variationId) {
  final key = '${productId}_$variationId';
  final stockMap = ref.watch(productVariationStockMapProvider);
  
  // Si hay stock actualizado en el mapa, usarlo
  if (stockMap.containsKey(key)) {
    return stockMap[key]!;
  }
  
  // Si no hay stock actualizado, buscar el stock original de la variación
  final allProductsAsync = ref.watch(allProductsProvider);
  return allProductsAsync.when(
    data: (products) {
      final product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception('Producto no encontrado: $productId'),
      );
      
      if (product.hasVariations) {
        final variation = product.variations.firstWhere(
          (v) => v.id == variationId,
          orElse: () => throw Exception('Variación no encontrada: $variationId'),
        );
        return variation.availableStock;
      }
      
      return 0;
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
}

/// Gestiona el filtro de categoría seleccionada
class SelectedCategoryFilter extends Notifier<int?> {
  @override
  int? build() => null;

  void selectCategory(int? categoryId) {
    state = categoryId;
  }

  void clearCategory() {
    state = null;
  }
}

final selectedCategoryFilterProvider = NotifierProvider<SelectedCategoryFilter, int?>(() => SelectedCategoryFilter());

/// Gestiona el filtro de subcategoría seleccionada
class SelectedSubcategoryFilter extends Notifier<int?> {
  @override
  int? build() => null;

  void selectSubcategory(int? subcategoryId) {
    state = subcategoryId;
  }

  void clearSubcategory() {
    state = null;
  }
}

final selectedSubcategoryFilterProvider = NotifierProvider<SelectedSubcategoryFilter, int?>(() => SelectedSubcategoryFilter());

/// Gestiona el estado expandido/colapsado de las secciones de productos por categoría
@Riverpod(keepAlive: true)
class CategoryProductsExpanded extends _$CategoryProductsExpanded {
  @override
  Map<String, bool> build() => {};

  void toggleExpanded(String categoryId) {
    state = {
      ...state,
      categoryId: !(state[categoryId] ?? false),
    };
  }

  bool isExpanded(String categoryId) {
    return state[categoryId] ?? false;
  }
}

/// Gestiona la paginación global de productos
class GlobalProductsPagination extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() => {};

  void showMore(String key, {int increment = 4}) {
    final currentCount = state[key] ?? 4;
    state = {
      ...state,
      key: currentCount + increment,
    };
  }

  void reset(String key) {
    state = {
      ...state,
      key: 4,
    };
  }

  void resetAll() {
    state = {};
  }

  int getVisibleCount(String key) {
    return state[key] ?? 4;
  }
}

final globalProductsPaginationProvider = NotifierProvider<GlobalProductsPagination, Map<String, int>>(() => GlobalProductsPagination());

/// Gestiona la paginación de productos mostrados por categoría (legacy - mantener compatibilidad)
class CategoryProductsPagination extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() => {};

  void showMore(String categoryId, {int increment = 4}) {
    final currentCount = state[categoryId] ?? 4;
    state = {
      ...state,
      categoryId: currentCount + increment,
    };
  }

  void reset(String categoryId) {
    state = {
      ...state,
      categoryId: 4,
    };
  }

  int getVisibleCount(String categoryId) {
    return state[categoryId] ?? 4;
  }
}

final categoryProductsPaginationProvider = NotifierProvider<CategoryProductsPagination, Map<String, int>>(() => CategoryProductsPagination());

/// Devuelve productos filtrados por categoría y/o subcategoría seleccionada con paginación
@Riverpod(keepAlive: true)
Future<List<Product>> filteredProductsPaginated(Ref ref) async {
  final selectedCategory = ref.watch(selectedCategoryFilterProvider);
  final selectedSubcategory = ref.watch(selectedSubcategoryFilterProvider);
  final pagination = ref.watch(globalProductsPaginationProvider);

  List<Product> products = [];
  String paginationKey = '';

  if (selectedCategory == null && selectedSubcategory == null) {
    // Sin filtros: devolver lista vacía (se manejan por categorías individuales)
    return [];
  }

  if (selectedCategory != null && selectedSubcategory == null) {
    // Filtro por categoría: productos de categoría + subcategorías con stock actualizado
    products = await ref.watch(productsByCategoryWithStockProvider(selectedCategory).future);
    paginationKey = 'category_$selectedCategory';
  }

  if (selectedSubcategory != null) {
    // Filtro por subcategoría: productos de subcategoría con stock actualizado
    final baseProducts = await ref.watch(productsBySubcategoryProvider(selectedSubcategory).future);
    products = baseProducts;
    paginationKey = 'subcategory_$selectedSubcategory';
  }

  // Aplicar paginación
  final visibleCount = pagination[paginationKey] ?? 4;
  return products.take(visibleCount).toList();
}


/// Provider que indica si hay más productos para mostrar en el filtro actual
@Riverpod(keepAlive: true)
Future<bool> hasMoreFilteredProducts(Ref ref) async {
  final selectedCategory = ref.watch(selectedCategoryFilterProvider);
  final selectedSubcategory = ref.watch(selectedSubcategoryFilterProvider);
  final pagination = ref.watch(globalProductsPaginationProvider);

  if (selectedCategory == null && selectedSubcategory == null) {
    return false;
  }

  List<Product> allProducts = [];
  String paginationKey = '';

  if (selectedCategory != null && selectedSubcategory == null) {
    allProducts = await ref.watch(productsByCategoryProvider(selectedCategory).future);
    paginationKey = 'category_$selectedCategory';
  }

  if (selectedSubcategory != null) {
    allProducts = await ref.watch(productsBySubcategoryProvider(selectedSubcategory).future);
    paginationKey = 'subcategory_$selectedSubcategory';
  }

  final visibleCount = pagination[paginationKey] ?? 4;
  return allProducts.length > visibleCount;
}

/// Función helper para obtener la URL base
String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: ' DEV_URL not found')
      : dotenv.get('PROD_URL', fallback: 'PROD_URL not found');
}

/// Provider del servicio de stock
@Riverpod(keepAlive: true)
StockService stockService(Ref ref) {
  return StockService(baseUrl: _getBaseUrl());
}


/// Helper para obtener el stock actual de un producto
int getProductStockHelper(Ref ref, int productId) {
  final stockMap = ref.read(productStockMapProvider);
  return stockMap[productId] ?? -1; // -1 indica que no hay override local
}

/// Provider que retorna productos con stock actualizado
@Riverpod(keepAlive: true)
Future<List<Product>> productsWithUpdatedStock(Ref ref) async {
  final products = await ref.watch(allProductsProvider.future);
  final stockUpdates = ref.watch(productStockMapProvider);
  
  return products.map((product) {
    final updatedStock = stockUpdates[product.id];
    if (updatedStock != null) {
      // Crear una copia del producto con el stock actualizado
      return product.copyWith(stock: updatedStock);
    }
    return product;
  }).toList();
}

/// Provider optimizado para productos base (sin refrescar por stock)
@Riverpod(keepAlive: true)
Future<List<Product>> productsBaseStable(Ref ref) async {
  return await ref.watch(allProductsProvider.future);
}

/// Provider para obtener stock específico de un producto
@riverpod
int productCurrentStock(Ref ref, int productId, int originalStock) {
  final stockUpdates = ref.watch(productStockMapProvider);
  return stockUpdates[productId] ?? originalStock;
}

/// Provider para productos por categoría con stock actualizado
/// Incluye productos directos de la categoría Y productos de sus subcategorías
@riverpod
Future<List<Product>> productsByCategoryWithStock(Ref ref, int categoryId) async {
  final productsWithStock = await ref.watch(allProductsProvider.future);
  
  // Obtener subcategorías de la categoría
  final subcategories = await ref.watch(subcategoriesByCategoryProvider(categoryId).future);
  final subcategoryIds = subcategories.map((sub) => sub.id).toSet();
  
  // Filtrar productos que pertenezcan a la categoría O a sus subcategorías
  final filteredProducts = productsWithStock.where((product) {
    final belongsToCategory = product.categoryId == categoryId;
    final belongsToSubcategory = product.subCategoryId != null && subcategoryIds.contains(product.subCategoryId);
    return belongsToCategory || belongsToSubcategory;
  }).toList();
  
  return filteredProducts;
}

// ELIMINADO: featuredProductsWithStock - Reemplazado por featuredProductsStable

/// Provider estable para productos destacados (CON stock actualizado)
@Riverpod(keepAlive: true)
Future<List<Product>> featuredProductsStable(Ref ref) async {
  // CRÍTICO: Usar productos con stock actualizado para consistencia
  final products = await ref.watch(productsBaseStableProvider.future);
  final featuredProducts = products.where((product) => product.isFavorite).toList();
  
  // Precargar imágenes en background (sin bloquear la UI)
  _preloadProductImages(ref, featuredProducts);
  
  return featuredProducts;
}

/// Función helper para precargar imágenes en background
void _preloadProductImages(Ref ref, List<Product> products) {
  // Ejecutar en el siguiente frame para no bloquear la UI
  Future.microtask(() async {
    try {
      final imageCacheService = ref.read(imageCacheServiceProvider);
      final baseUrl = ref.read(baseUrlProvider);
      
      print('📥 ProductsProvider: Iniciando precarga de ${products.length} imágenes destacadas');
      
      for (final product in products.take(10)) { // Limitar a 10 para no sobrecargar
        try {
          final imageUrl = product.getMainImageUrl(baseUrl);
          if (imageUrl != null) {
            await imageCacheService.precacheImage(imageUrl);
          }
        } catch (e) {
          print('⚠️ ProductsProvider: Error precargando imagen del producto ${product.id}: $e');
        }
      }
      
      print('✅ ProductsProvider: Precarga de imágenes completada');
    } catch (e) {
      print('⚠️ ProductsProvider: Error en precarga de imágenes: $e');
    }
  });
}

// ELIMINADO: productsBySubcategoryWithStock - No se usa en el proyecto

/// Valida el stock de un producto antes de agregarlo al carrito
@riverpod
Future<StockResponse> validateProductStock(
  Ref ref, 
  int productId, 
  int quantity, {
  int? variationId,
}) async {
  // Verificar primero el stock local actualizado
  final localStock = getProductStockHelper(ref, productId);
  
  // Si el stock local es 0, no permitir agregar
  if (localStock == 0) {
    print('❌ ValidateStock: Producto ID $productId tiene stock 0 localmente');
    return const StockResponse(
      isAvailable: false,
      availableStock: 0,
      message: 'Producto agotado',
    );
  }
  
  final stockService = ref.watch(stockServiceProvider);
  final response = await stockService.checkProductStock(
    productId, 
    quantity,
    variationId: variationId,
  );
  
  // Si la respuesta es exitosa, actualizar el stock local
  if (response.isAvailable && response.additionalData != null) {
    final newStock = response.additionalData!['stock_available'] as int?;
    if (newStock != null) {
      updateProductStockHelper(ref, productId, newStock);
    }
  }
  
  return response;
}

/// Elimina un producto del carrito
@riverpod
Future<StockResponse> removeProductFromCart(Ref ref, int productId, {int? variationId}) async {
  final stockService = ref.watch(stockServiceProvider);
  final response = await stockService.removeProductFromCart(productId, variationId: variationId);
  
  // Si la eliminación es exitosa, actualizar el stock local
  if (response.isAvailable && response.additionalData != null) {
    final newStock = response.additionalData!['stock_available'] as int?;
    if (newStock != null) {
      updateProductStockHelper(ref, productId, newStock);
    }
  }
  
  return response;
}

/// Limpia el carrito completo y repone el stock
@riverpod
Future<StockResponse> clearCartAndRestoreStock(Ref ref) async {
  final stockService = ref.watch(stockServiceProvider);
  final response = await stockService.clearCart();
  
  // Si la limpieza es exitosa, actualizar el stock local de todos los productos
  if (response.isAvailable && response.additionalData != null) {
    final stockUpdates = response.additionalData!['stock_updates'] as Map<int, int>?;
    if (stockUpdates != null) {
      for (final entry in stockUpdates.entries) {
        final productId = entry.key;
        final newStock = entry.value;
        updateProductStockHelper(ref, productId, newStock);
      }
    }
  }
  
  return response;
}

/// Actualiza la cantidad de un combo en el carrito y ajusta el stock
@riverpod
Future<StockResponse> updateComboStock(Ref ref, int comboId, int quantity) async {
  print('📡 updateComboStockProvider: ========== INICIO ==========');
  print('📡 updateComboStockProvider: Combo ID: $comboId');
  print('📡 updateComboStockProvider: Cantidad: $quantity');
  
  try {
    final stockService = ref.watch(stockServiceProvider);
    print('📡 updateComboStockProvider: Llamando stockService.updateComboCart...');
    
    final response = await stockService.updateComboCart(comboId, quantity);
    
    print('📡 updateComboStockProvider: ========== RESPUESTA RECIBIDA ==========');
    print('📡 updateComboStockProvider: - isAvailable: ${response.isAvailable}');
    print('📡 updateComboStockProvider: - availableStock: ${response.availableStock}');
    print('📡 updateComboStockProvider: - message: ${response.message}');
    if (response.additionalData != null) {
      print('📡 updateComboStockProvider: - additionalData: ${response.additionalData}');
    }
    
    // Si la actualización es exitosa, actualizar el stock local de todos los productos afectados
    if (response.isAvailable && response.additionalData != null) {
      print('📡 updateComboStockProvider: Procesando actualizaciones de stock...');
      final stockUpdates = response.additionalData!['stock_updates'] as Map<int, int>?;
      if (stockUpdates != null) {
        print('📡 updateComboStockProvider: Stock updates encontrados: $stockUpdates');
        for (final entry in stockUpdates.entries) {
          final productId = entry.key;
          final newStock = entry.value;
          print('📡 updateComboStockProvider: Actualizando producto $productId a stock $newStock');
          updateProductStockHelper(ref, productId, newStock);
        }
      } else {
        print('📡 updateComboStockProvider: No hay stock updates en additionalData');
      }
    } else {
      print('📡 updateComboStockProvider: No se procesan stock updates - response no disponible o sin additionalData');
    }
    
    print('📡 updateComboStockProvider: ========== FIN ==========');
    return response;
    
  } catch (e, stackTrace) {
    print('💥 updateComboStockProvider: ERROR: $e');
    print('💥 updateComboStockProvider: Stack trace: $stackTrace');
    rethrow;
  }
}

/// Actualiza la cantidad de un combo con variaciones en el carrito
@riverpod
Future<StockResponse> updateComboStockWithVariations(
  Ref ref,
  int comboId,
  int quantity,
  Map<int, int> selectedVariations,
) async {
  print('📡 updateComboStockWithVariationsProvider: ========== INICIO ==========');
  print('📡 updateComboStockWithVariationsProvider: Combo ID: $comboId');
  print('📡 updateComboStockWithVariationsProvider: Cantidad: $quantity');
  print('📡 updateComboStockWithVariationsProvider: Variaciones: $selectedVariations');
  
  try {
    final stockService = ref.watch(stockServiceProvider);
    
    final response = await stockService.updateComboCartWithVariations(
      comboId,
      quantity,
      selectedVariations,
    );
    
    print('📡 updateComboStockWithVariationsProvider: ========== RESPUESTA ==========');
    print('📡 updateComboStockWithVariationsProvider: - isAvailable: ${response.isAvailable}');
    print('📡 updateComboStockWithVariationsProvider: - message: ${response.message}');
    
    // Actualizar stock local de productos afectados
    if (response.isAvailable && response.additionalData != null) {
      final stockUpdates = response.additionalData!['stock_updates'] as Map<int, int>?;
      if (stockUpdates != null) {
        print('📡 updateComboStockWithVariationsProvider: Actualizando stocks...');
        for (final entry in stockUpdates.entries) {
          updateProductStockHelper(ref, entry.key, entry.value);
        }
      }
    }
    
    print('📡 updateComboStockWithVariationsProvider: ========== FIN ==========');
    return response;
    
  } catch (e, stackTrace) {
    print('💥 updateComboStockWithVariationsProvider: ERROR: $e');
    print('💥 Stack trace: $stackTrace');
    rethrow;
  }
}
