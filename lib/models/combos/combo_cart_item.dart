import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';

part 'combo_cart_item.freezed.dart';
part 'combo_cart_item.g.dart';

/// Modelo para representar un combo en el carrito de compras.
@freezed
sealed class ComboCartItem with _$ComboCartItem {
  /// Constructor principal del ComboCartItem.
  /// [combo]: combo asociado al item.
  /// [quantity]: cantidad del combo en el carrito.
  /// [addedAt]: timestamp cuando se agregó al carrito.
  const factory ComboCartItem({
    required Combo combo,
    @Default(1) int quantity,
    DateTime? addedAt,
  }) = _ComboCartItem;

  factory ComboCartItem.fromJson(Map<String, dynamic> json) => _$ComboCartItemFromJson(json);
}

/// Extensiones para cálculos del ComboCartItem.
extension ComboCartItemExtensions on ComboCartItem {
  /// Calcula el precio total del item (precio unitario * cantidad).
  double get totalPrice {
    return (combo.hasDiscount ? combo.discountedPriceAsDouble : combo.priceAsDouble) * quantity;
  }

  /// Calcula el total de descuentos del item.
  double get totalDiscount {
    return combo.discountAmount * quantity;
  }

  /// Calcula el precio original total sin descuentos.
  double get originalTotalPrice {
    return combo.priceAsDouble * quantity;
  }

  /// Indica si el item tiene descuento.
  bool get hasDiscount => combo.hasDiscount;

  /// Porcentaje de descuento del combo.
  double? get discountPercentage => combo.discountPercentage;

  /// Crea una copia del ComboCartItem con nueva cantidad.
  ComboCartItem withQuantity(int newQuantity) {
    return copyWith(quantity: newQuantity);
  }

  /// Incrementa la cantidad del item en 1.
  ComboCartItem incrementQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  /// Decrementa la cantidad del item en 1 (mínimo 1).
  ComboCartItem decrementQuantity() {
    return copyWith(quantity: quantity > 1 ? quantity - 1 : 1);
  }

  /// ID único del combo para identificación en el carrito.
  String get id => combo.id.toString();
}
