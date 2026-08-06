import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/products/product_variation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

/// Modelo para representar un item en el carrito de compras.
@freezed
sealed class CartItem with _$CartItem {
  /// Constructor principal del CartItem.
  /// [product]: producto asociado al item.
  /// [quantity]: cantidad del producto en el carrito.
  /// [selectedVariation]: variación seleccionada del producto (si aplica).
  /// [addedAt]: timestamp cuando se agregó al carrito.
  const factory CartItem({
    required Product product,
    @Default(1) int quantity,
    ProductVariation? selectedVariation,
    DateTime? addedAt,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}

/// Extensiones para cálculos del CartItem.
extension CartItemExtensions on CartItem {
  /// Calcula el precio total del item (precio unitario * cantidad).
  double get totalPrice {
    return product.finalPrice * quantity;
  }

  /// Calcula el total de descuentos del item.
  double get totalDiscount {
    return product.discountAmount * quantity;
  }

  /// Calcula el precio original total sin descuentos.
  double get originalTotalPrice {
    return product.priceAsDouble * quantity;
  }

  /// Indica si el item tiene descuento.
  bool get hasDiscount => product.hasDiscount;

  /// Porcentaje de descuento del producto.
  double? get discountPercentage => product.discountPercentage;

  /// Crea una copia del CartItem con nueva cantidad.
  CartItem withQuantity(int newQuantity) {
    return copyWith(quantity: newQuantity);
  }

  /// Incrementa la cantidad del item en 1.
  CartItem incrementQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  /// Decrementa la cantidad del item en 1 (mínimo 1).
  CartItem decrementQuantity() {
    return copyWith(quantity: quantity > 1 ? quantity - 1 : 1);
  }

  /// SKU efectivo (variación o producto)
  String get effectiveSku => selectedVariation?.sku ?? product.sku;

  /// Stock disponible (variación o producto)
  int get availableStock => selectedVariation?.availableStock ?? product.effectiveStock;

  /// Descripción para mostrar (incluye variación si existe)
  String get displayName {
    if (selectedVariation != null) {
      return '${product.name}\n${selectedVariation!.formattedAttributes}';
    }
    return product.name;
  }

  /// Descripción corta para tickets (una línea)
  String get displayNameShort {
    if (selectedVariation != null) {
      return '${product.name} (${selectedVariation!.formattedAttributes})';
    }
    return product.name;
  }

  /// Indica si el item tiene variación seleccionada
  bool get hasVariation => selectedVariation != null;
}
