import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/models/categories/subcategory.dart';
import 'package:riverpod/riverpod.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';

part 'subcategories_provider.g.dart';

/// Provider que obtiene las subcategorías de la categoría seleccionada
@Riverpod(keepAlive: true)
List<Subcategory> subcategoriesForSelectedCategory(Ref ref, int? selectedCategoryId) {
  if (selectedCategoryId == null) return [];
  
  final categoriesAsync = ref.watch(allCategoriesProvider);
  
  return categoriesAsync.when(
    data: (categories) {
      final selectedCategory = categories.firstWhere(
        (category) => category.id == selectedCategoryId,
        orElse: () => throw StateError('Category not found'),
      );
      return selectedCategory.subCategories;
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
