import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/categories/category.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/categories/subcategory.dart';
import 'package:ventas_kiosko/services/categories_products_service.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/utils/product_catalog.dart';

part 'master_data_provider.g.dart';

String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: ' DEV_URL not found')
      : dotenv.get('PROD_URL', fallback: 'PROD_URL not found');
}

/// Provider maestro que obtiene todas las categorías con subcategorías y productos
@Riverpod(keepAlive: true)
Future<List<Category>> masterData(Ref ref) async {
  final tenantId = ref.read(licenseProvider.notifier).requireTenantId();
  print('🏢 MasterDataProvider: Using tenant ID: $tenantId');
  
  final service = CategoriesProductsService(
    baseUrl: _getBaseUrl(),
    tenantId: tenantId,
  );
  return await service.fetchCategoriesWithProducts();
}

/// Provider derivado que extrae todas las categorías del cache maestro
@Riverpod(keepAlive: true)
Future<List<Category>> allCategories(Ref ref) async {
  final masterData = await ref.watch(masterDataProvider.future);
  return masterData;
}

/// Provider derivado que extrae todos los productos de categorías y subcategorías
@Riverpod(keepAlive: true)
Future<List<Product>> allProducts(Ref ref) async {
  final categories = await ref.watch(masterDataProvider.future);
  final List<Product> allProducts = [];
  
  for (final category in categories) {
    // Agregar productos directos de la categoría
    allProducts.addAll(category.products);
    
    // Agregar productos de las subcategorías
    for (final subcategory in category.subCategories) {
      allProducts.addAll(subcategory.products);
    }
  }
  
  return allProducts;
}

/// Provider que filtra productos favoritos (is_favorite = true)
@Riverpod(keepAlive: true)
Future<List<Product>> featuredProducts(Ref ref) async {
  final allProducts = await ref.watch(allProductsProvider.future);
  return allProducts
      .where((product) => product.isFavorite && ProductCatalog.isPublishedSku(product.sku))
      .toList();
}

/// Provider que obtiene productos por categoría
@Riverpod(keepAlive: true)
Future<List<Product>> productsByCategory(Ref ref, int categoryId) async {
  final categories = await ref.watch(masterDataProvider.future);

  final category = categories.firstWhere(
    (cat) => cat.id == categoryId,
    orElse: () => throw Exception('Categoría no encontrada'),
  );
  
  // Si la categoría tiene productos directos, devolverlos
  if (category.products.isNotEmpty) {
    return ProductCatalog.publishedOnly(category.products);
  }
  
  // Si no tiene productos directos, obtener de subcategorías
  final List<Product> productsFromSubcategories = [];
  for (final subcategory in category.subCategories) {
    // Tomar máximo 4 productos por subcategoría
    final subcategoryProducts = subcategory.products.take(4).toList();
    productsFromSubcategories.addAll(subcategoryProducts);
  }
  
  return ProductCatalog.publishedOnly(productsFromSubcategories);
}

/// Provider que obtiene productos por subcategoría
@Riverpod(keepAlive: true)
Future<List<Product>> productsBySubcategory(Ref ref, int subcategoryId) async {
  final categories = await ref.watch(masterDataProvider.future);
    
  for (final category in categories) {
    for (final subcategory in category.subCategories) {
      if (subcategory.id == subcategoryId) {
        return ProductCatalog.publishedOnly(subcategory.products);
      }
    }
  }
  
  return [];
}

/// Provider que obtiene subcategorías por categoría
@Riverpod(keepAlive: true)
Future<List<Subcategory>> subcategoriesByCategory(Ref ref, int categoryId) async {
  final categories = await ref.watch(masterDataProvider.future);
  
  final category = categories.firstWhere(
    (cat) => cat.id == categoryId,
    orElse: () => throw Exception('Categoría no encontrada'),
  );
  
  return category.subCategories;
}
