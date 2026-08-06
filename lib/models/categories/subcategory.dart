import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/models/products/product.dart';

part 'subcategory.freezed.dart';
part 'subcategory.g.dart';

/// Modelo que representa una subcategoría de productos.
@freezed
sealed class Subcategory with _$Subcategory {
  /// [id]: identificador único de la subcategoría.
  /// [name]: nombre de la subcategoría.
  /// [categoryId]: id de la categoría principal asociada.
  /// [description]: descripción opcional.
  /// [icon]: ícono a usar en la UI.
  const factory Subcategory({
    required int id,
    required String name,
    String? categoryId,
    String? description,
    AppIconData? icon,
    @Default([]) List<Product> products,
  }) = _Subcategory;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory.fromCustomJson(json);

  /// Método personalizado para parseo desde JSON
  factory Subcategory.fromCustomJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as int,
      name: json['name'] as String,
      categoryId: json['category_id'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] != null 
          ? AppIconDataMapExtension.fromMap(json['icon'] as Map<String, dynamic>)
          : null,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}
