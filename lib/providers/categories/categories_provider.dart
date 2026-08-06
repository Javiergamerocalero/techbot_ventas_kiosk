import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/models/categories/category.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';

part 'categories_provider.g.dart';

/// Provider que obtiene todas las categorías desde el sistema maestro
@Riverpod(keepAlive: true)
Future<List<Category>> categories(Ref ref) async {
  return await ref.watch(allCategoriesProvider.future);
}
