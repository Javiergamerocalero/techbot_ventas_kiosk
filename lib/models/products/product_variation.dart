import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_variation.freezed.dart';
part 'product_variation.g.dart';

@freezed
sealed class ProductVariation with _$ProductVariation {
  const ProductVariation._();

  const factory ProductVariation({
    required int id,
    @JsonKey(name: 'product_id') required int productId,
    String? sku,
    required Map<String, dynamic> attributes,
    @JsonKey(name: 'formatted_attributes') required String formattedAttributes,
    required int stock,
    @JsonKey(name: 'available_stock') required int availableStock,
    @JsonKey(name: 'reserved_stock') required int reservedStock,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _ProductVariation;

  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      _$ProductVariationFromJson(json);

  String? getAttribute(String key) {
    final value = attributes[key];
    return value?.toString();
  }

  bool hasAttribute(String key) {
    return attributes.containsKey(key);
  }

  String? get colorHex {
    // Primero intentar obtener del atributo 'HEX Color' (formato antiguo)
    final hexColor = getAttribute('HEX Color');
    if (hexColor != null) return hexColor;
    
    // Si no existe, intentar parsear del atributo 'Color' con formato "Nombre|#hex"
    final colorValue = getAttribute('Color');
    if (colorValue != null && colorValue.contains('|')) {
      final parts = colorValue.split('|');
      if (parts.length == 2) {
        return parts[1].trim(); // Retornar el código hex
      }
    }
    
    return null;
  }

  String? get size {
    return getAttribute('Talla');
  }

  String? get color {
    final colorValue = getAttribute('Color');
    if (colorValue == null) return null;
    
    // Si tiene formato "Nombre|#hex", retornar solo el nombre
    if (colorValue.contains('|')) {
      final parts = colorValue.split('|');
      if (parts.length == 2) {
        return parts[0].trim(); // Retornar solo el nombre del color
      }
    }
    
    // Si no tiene el formato, retornar el valor completo
    return colorValue;
  }
  
  String? get colorName {
    return color; // Alias para mayor claridad
  }

  bool get isOutOfStock => availableStock <= 0;

  bool get hasStock => availableStock > 0;
}
