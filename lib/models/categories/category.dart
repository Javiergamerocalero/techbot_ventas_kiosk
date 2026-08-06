import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ventas_kiosko/models/categories/subcategory.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/models/products/product.dart';

part 'category.freezed.dart';
part 'category.g.dart';


/// Modelo que representa una categoría de productos.
@freezed
sealed class Category with _$Category {
  /// [id]: identificador único.
  /// [name]: nombre de la categoría.
  /// [description]: descripción breve (opcional).
  /// [icon]: ícono a usar en la UI.
  /// [subCategories]: lista de subcategorías asociadas.
  const factory Category({
    required int id,
    required String name,
    String? description,
    AppIconData? icon,
    @Default([]) List<Product> products,
    @Default([]) List<Subcategory> subCategories,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => Category.fromCustomJson(json);

  /// Método personalizado para parseo desde JSON
  factory Category.fromCustomJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      icon: json['icon'] != null 
          ? AppIconDataMapExtension.fromMap(json['icon'] as Map<String, dynamic>)
          : null,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      subCategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}
