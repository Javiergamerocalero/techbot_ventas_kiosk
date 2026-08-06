import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ventas_kiosko/models/products/product.dart';

part 'combo.freezed.dart';
part 'combo.g.dart';

/// Modelo para un combo.
@freezed
sealed class Combo with _$Combo {
  /// [id]: identificador único del combo.
  /// [name]: nombre del combo.
  /// [description]: descripción breve.
  /// [price]: precio base.
  /// [hasTax]: indica si tiene impuesto.
  /// [taxPercentage]: porcentaje de impuesto si aplica.
  /// [hasDiscount]: indica si tiene descuento.
  /// [discountPercentage]: porcentaje de descuento si aplica.
  /// [discountedPrice]: precio con descuento aplicado.
  /// [finalPrice]: precio final con impuesto y descuento aplicado.
  /// [thumbnail]: imagen pequeña o principal por defecto.
  /// [images]: lista de imágenes adicionales del combo.
  /// [isActive]: indica si el combo está activo.
  /// [products]: lista de productos que incluye el combo.
  /// [currencyCode]: código de moneda (ej. PEN, USD).
  /// [currencySymbol]: símbolo de moneda (ej. PEN, $).
  /// [requiresVariationSelection]: indica si es obligatorio seleccionar variaciones.
  const factory Combo({
    required int id,
    required String name,
    required String description,
    required String price,
    @Default(false) bool hasTax,
    double? taxPercentage,
    @Default(false) bool hasDiscount,
    double? discountPercentage,
    required String discountedPrice,
    String? finalPrice,
    required String thumbnail,
    @Default([]) List<Map<String, dynamic>> images,
    @Default(true) bool isActive,
    @Default([]) List<Product> products,
    @Default(5) int stock,
    @Default('') String sku,
    @Default('PEN') String currencyCode,
    @Default('PEN') String currencySymbol,
    @Default(false) @JsonKey(name: 'requires_variation_selection') bool requiresVariationSelection,
  }) = _Combo;

  factory Combo.fromJson(Map<String, dynamic> json) => Combo.fromCustomJson(json);

  /// Método para parseo especial
  factory Combo.fromCustomJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      return value.toString();
    }
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }
    return Combo(
      id: json['id'] as int,
      name: parseString(json['name']),
      description: parseString(json['description']),
      price: parseString(json['price']),
      hasTax: json['has_tax'] as bool? ?? false,
      taxPercentage: parseDouble(json['tax_percentage']),
      hasDiscount: json['has_discount'] as bool? ?? false,
      discountPercentage: parseDouble(json['discount_percentage']),
      discountedPrice: parseString(json['discounted_price']),
      finalPrice: json['final_price'] != null ? parseString(json['final_price']) : null,
      thumbnail: parseString(json['thumbnail']),
      images: (json['images'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      isActive: json['is_active'] as bool? ?? true,
      products: (json['products'] as List<dynamic>?)?.map((p) => Product.fromJson(p as Map<String, dynamic>)).toList() ?? [],
      stock: json['stock'] as int? ?? 5,
      sku: parseString(json['sku']),
      currencyCode: parseString(json['currency_code']).isEmpty ? 'PEN' : parseString(json['currency_code']),
      currencySymbol: parseString(json['currency_symbol']).isEmpty ? 'PEN' : parseString(json['currency_symbol']),
      requiresVariationSelection: json['requires_variation_selection'] as bool? ?? false,
    );
  }

}

extension ComboExtension on Combo {
  /// Devuelve el precio como double desde string.
  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  
  /// Devuelve el precio con descuento como double desde string.
  double get discountedPriceAsDouble => double.tryParse(discountedPrice) ?? 0.0;
  
  /// Devuelve el precio final con descuento aplicado (si corresponde).
  double get finalPrice => hasDiscount ? discountedPriceAsDouble : priceAsDouble;

  /// Devuelve el monto de descuento aplicado.
  double get discountAmount => priceAsDouble - discountedPriceAsDouble;

  /// Devuelve el precio final formateado con símbolo de moneda.
  String get formattedPrice => '$currencySymbol${finalPrice.toStringAsFixed(2)}';
  
  /// Devuelve el precio original formateado con símbolo de moneda.
  String get formattedOriginalPrice => '$currencySymbol${priceAsDouble.toStringAsFixed(2)}';
  
  /// Devuelve el precio con descuento formateado con símbolo de moneda.
  String get formattedDiscountedPrice => '$currencySymbol${discountedPriceAsDouble.toStringAsFixed(2)}';

  /// Devuelve la URL de la imagen principal o el thumbnail.
  String get mainImageUrl {
    if (images.isNotEmpty) {
      final firstImage = images.first;
      return firstImage['url'] ?? thumbnail;
    }
    return thumbnail;
  }

  /// Indica si el combo tiene múltiples imágenes.
  bool get hasMultipleImages => images.length > 1;

  /// Obtiene la primera imagen ordenada por prioridad
  Map<String, dynamic>? get primaryImage {
    if (images.isEmpty) return null;
    
    final sortedImages = List<Map<String, dynamic>>.from(images)
      ..sort((a, b) {
        final priorityA = a['priority'] as int? ?? 999;
        final priorityB = b['priority'] as int? ?? 999;
        return priorityA.compareTo(priorityB);
      });
    
    return sortedImages.first;
  }

  /// Obtiene todas las imágenes ordenadas por prioridad
  List<Map<String, dynamic>> get sortedImages {
    return List<Map<String, dynamic>>.from(images)
      ..sort((a, b) {
        final priorityA = a['priority'] as int? ?? 999;
        final priorityB = b['priority'] as int? ?? 999;
        return priorityA.compareTo(priorityB);
      });
  }

  /// Construye la URL completa de la imagen principal
  String? getMainImageUrl(String baseUrl) {
    final primaryImg = primaryImage;
    if (primaryImg != null) {
      final partialUrl = primaryImg['url'] as String?;
      if (partialUrl != null && partialUrl.isNotEmpty) {
        final cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
        final cleanPartialUrl = partialUrl.startsWith('/') ? partialUrl : '/$partialUrl';
        return '$cleanBaseUrl$cleanPartialUrl';
      }
    }
    
    if (thumbnail.isNotEmpty) {
      final cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      final cleanThumbnail = thumbnail.startsWith('/') ? thumbnail : '/$thumbnail';
      return '$cleanBaseUrl$cleanThumbnail';
    }
    
    return null;
  }

  /// Indica si el combo tiene imágenes válidas
  bool get hasValidImages => images.isNotEmpty || thumbnail.isNotEmpty;

  /// Indica si el combo tiene stock disponible basado en sus productos
  /// Un combo NO tiene stock si al menos uno de sus productos tiene stock 0
  bool get hasStock {
    if (products.isEmpty) return stock > 0; // Fallback al stock del combo
    
    // Si algún producto tiene stock 0, el combo no tiene stock
    return products.every((product) => product.effectiveStock > 0);
  }

  /// Indica si el combo está sin stock (inverso de hasStock)
  bool get isOutOfStock => !hasStock;
}
