import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_image.freezed.dart';
part 'product_image.g.dart';

/// Modelo que representa una imagen de producto.
@freezed
sealed class ProductImage with _$ProductImage {
  /// [id]: identificador único de la imagen.
  /// [url]: URL o ruta de la imagen.
  /// [title]: título descriptivo opcional.
  /// [priority]: prioridad para ordenamiento (1 = mayor prioridad).
  const factory ProductImage({
    required int id,
    required String url,
    @Default('') String title,
    @Default(1) int priority,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);
}

/// Extensión con helpers para ProductImage.
extension ProductImageExtension on ProductImage {
  /// Indica si es la imagen principal (prioridad 1).
  bool get isMainImage => priority == 1;

  /// Valida que la URL no esté vacía.
  bool get hasValidUrl => url.isNotEmpty;
}

/// Extensión para listas de ProductImage.
extension ProductImageListExtension on List<ProductImage> {
  /// Ordena las imágenes por prioridad ascendente (1 es mayor prioridad).
  List<ProductImage> get sortedByPriority {
    final sorted = List<ProductImage>.from(this);
    sorted.sort((a, b) => a.priority.compareTo(b.priority));
    return sorted;
  }

  /// Obtiene la imagen principal (menor prioridad numérica).
  ProductImage? get mainImage {
    if (isEmpty) return null;
    return sortedByPriority.first;
  }

  /// Obtiene todas las imágenes excepto la principal.
  List<ProductImage> get secondaryImages {
    if (isEmpty) return [];
    final sorted = sortedByPriority;
    return sorted.skip(1).toList();
  }
}
