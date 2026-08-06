import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_variation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// Modelo que representa un producto del menú.
@freezed
sealed class Product with _$Product {
  /// [id]: identificador único del producto.
  /// [name]: nombre del producto.
  /// [description]: descripción breve.
  /// [price]: precio base.
  /// [hasDiscount]: indica si tiene descuento.
  /// [discountPercentage]: porcentaje de descuento si aplica.
  /// [thumbnail]: imagen pequeña o principal por defecto.
  /// [productImages]: lista de imágenes adicionales del producto.
  /// [categoryId]: id de la categoría principal.
  /// [subCategoryId]: id de subcategoría (opcional).
  /// [currencyCode]: código de moneda (ej. PEN, USD).
  /// [currencySymbol]: símbolo de moneda (ej. PEN, $).
  /// [hasVariations]: indica si el producto tiene variaciones.
  /// [variations]: lista de variaciones del producto.
  /// [requiresVariationSelection]: indica si es obligatorio seleccionar una variación.
  const factory Product({
    required int id,
    required String name,
    required String description,
    required String price,
    @Default(false) bool hasDiscount,
    double? discountPercentage,
    required String discountedPrice,
    required String thumbnail,
    @Default([]) List<Map<String, dynamic>> images,
    required int categoryId,
    int? subCategoryId,
    @Default(false) bool isFavorite,
    int? stock,
    int? availableStock,
    int? reservedStock,
    @Default('') String sku,
    @Default(false) bool hasVariations,
    @Default([]) List<ProductVariation> variations,
    @Default('PEN') String currencyCode,
    @Default('PEN') String currencySymbol,
    @Default(false) @JsonKey(name: 'requires_variation_selection') bool requiresVariationSelection,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => Product.fromCustomJson(json);

  /// Método para parsing seguro desde API con snake_case
  factory Product.fromCustomJson(Map<String, dynamic> json) {
    // Función helper para parsing seguro de strings
    String parseString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      return value.toString();
    }

    // Función helper para parsing seguro de doubles
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    // Función helper para parsing seguro de ints
    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    // Función helper para parsing seguro de images (maneja {} y [])
    List<Map<String, dynamic>> parseImages(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.cast<Map<String, dynamic>>();
      }
      if (value is Map && value.isEmpty) {
        // Si es un objeto vacío {}, retornar array vacío
        return [];
      }
      return [];
    }

    // Función helper para parsing seguro de variations (maneja {} y [])
    List<ProductVariation> parseVariations(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value
            .map((v) => ProductVariation.fromJson(v as Map<String, dynamic>))
            .toList();
      }
      if (value is Map && value.isEmpty) {
        // Si es un objeto vacío {}, retornar array vacío
        return [];
      }
      return [];
    }

    return Product(
      id: json['id'] as int,
      name: parseString(json['name']),
      description: parseString(json['description']),
      price: parseString(json['price']),
      hasDiscount: json['has_discount'] as bool? ?? false,
      discountPercentage: parseDouble(json['discount_percentage']),
      discountedPrice: parseString(json['discounted_price']),
      thumbnail: parseString(json['thumbnail']),
      images: parseImages(json['images']),
      categoryId: json['category_id'] as int,
      subCategoryId: parseInt(json['subcategory_id']),
      isFavorite: json['is_favorite'] as bool? ?? false,
      stock: parseInt(json['stock']),
      availableStock: parseInt(json['available_stock']),
      reservedStock: parseInt(json['reserved_stock']),
      sku: parseString(json['sku']),
      hasVariations: json['has_variations'] as bool? ?? false,
      variations: parseVariations(json['variations']),
      currencyCode: parseString(json['currency_code']).isEmpty ? 'PEN' : parseString(json['currency_code']),
      currencySymbol: parseString(json['currency_symbol']).isEmpty ? 'PEN' : parseString(json['currency_symbol']),
      requiresVariationSelection: json['requires_variation_selection'] as bool? ?? false,
    );
  }
}

/// Extensión con helpers para lógica de negocio sobre productos.
extension ProductExtension on Product {
  /// Devuelve el precio como double desde string.
  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  
  /// Devuelve el precio con descuento como double desde string.
  double get discountedPriceAsDouble => double.tryParse(discountedPrice) ?? 0.0;
  
  /// Devuelve el precio final con descuento aplicado (si corresponde).
  double get finalPrice => hasDiscount ? discountedPriceAsDouble : priceAsDouble;

  /// Devuelve el monto ahorrado por el descuento (si aplica).
  double get discountAmount {
    if (hasDiscount && discountPercentage != null) {
      return priceAsDouble - finalPrice;
    }
    return 0.0;
  }

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

  /// Indica si el producto tiene múltiples imágenes.
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

  /// Indica si el producto tiene imágenes válidas
  bool get hasValidImages => images.isNotEmpty || thumbnail.isNotEmpty;

  /// Stock efectivo (del producto o suma de variaciones activas)
  int get effectiveStock {
    if (hasVariations) {
      return variations
          .where((v) => v.isActive)
          .fold(0, (sum, v) => sum + v.availableStock);
    }
    return availableStock ?? stock ?? 0;
  }

  /// Verifica si el producto está agotado
  bool get isOutOfStock => effectiveStock <= 0;

  /// Obtiene una variación por su ID
  ProductVariation? getVariationById(int variationId) {
    try {
      return variations.firstWhere((v) => v.id == variationId);
    } catch (_) {
      return null;
    }
  }

  /// Obtiene variaciones activas con stock disponible
  List<ProductVariation> get availableVariations {
    return variations.where((v) => v.isActive && v.hasStock).toList();
  }

  /// Indica si tiene variaciones disponibles
  bool get hasAvailableVariations => availableVariations.isNotEmpty;
}
