import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ventas_kiosko/models/cart/cart_item.dart';
import 'package:ventas_kiosko/models/combos/combo_cart_item.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/coupon/coupon.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

/// Modelo que representa el carrito de compras completo.
@freezed
sealed class Cart with _$Cart {
  /// [items]: lista de items de productos en el carrito.
  /// [comboItems]: lista de items de combos en el carrito.
  /// [cartDiscountPercentage]: descuento adicional a nivel de carrito.
  /// [appliedCoupon]: cupón aplicado al carrito.
  /// [updatedAt]: timestamp de última actualización.
  const factory Cart({
    @Default([]) List<CartItem> items,
    @Default([]) List<ComboCartItem> comboItems,
    @Default(0.0) double cartDiscountPercentage,
    @CouponConverter() @Default(null) Coupon? appliedCoupon,
    DateTime? updatedAt,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

/// Extensiones para cálculos del carrito.
extension CartExtensions on Cart {
  /// Calcula el precio total del carrito (productos + combos).
  double get totalPrice {
    final productTotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final comboTotal = comboItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    return productTotal + comboTotal;
  }
  
  /// Calcula el total de descuentos del carrito (productos + combos).
  double get totalDiscount {
    final productDiscounts = items.fold(0.0, (sum, item) => sum + item.totalDiscount);
    final comboDiscounts = comboItems.fold(0.0, (sum, item) => sum + item.totalDiscount);
    return productDiscounts + comboDiscounts;
  }
  
  /// Calcula el subtotal sin descuentos de carrito (productos + combos).
  double get subtotal {
    final productSubtotal = items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    final comboSubtotal = comboItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    return productSubtotal + comboSubtotal;
  }

  /// Calcula el total de descuentos por productos y combos.
  double get productDiscounts {
    final productDiscounts = items.fold<double>(0.0, (sum, item) => sum + item.totalDiscount);
    final comboDiscounts = comboItems.fold<double>(0.0, (sum, item) => sum + item.totalDiscount);
    return productDiscounts + comboDiscounts;
  }

  /// Calcula el descuento a nivel de carrito.
  double get cartDiscount {
    return cartDiscountPercentage > 0 
        ? subtotal * (cartDiscountPercentage / 100)
        : 0.0;
  }

  /// Calcula el precio total final con todos los descuentos aplicados.
  double get computedTotalPrice {
    final subtotalWithProductDiscounts = subtotal;
    return cartDiscountPercentage > 0
        ? subtotalWithProductDiscounts * (1 - cartDiscountPercentage / 100)
        : subtotalWithProductDiscounts;
  }

  /// Calcula la cantidad total de items en el carrito (productos + combos).
  int get totalItems {
    final productItems = items.fold<int>(0, (sum, item) => sum + item.quantity);
    final comboItemsCount = comboItems.fold<int>(0, (sum, item) => sum + item.quantity);
    return productItems + comboItemsCount;
  }

  /// Indica si el carrito está vacío (sin productos ni combos).
  bool get isEmpty => items.isEmpty && comboItems.isEmpty;

  /// Indica si el carrito tiene items (productos o combos).
  bool get isNotEmpty => items.isNotEmpty || comboItems.isNotEmpty;

  /// Calcula el total de descuentos (productos + carrito).
  double get totalDiscounts => productDiscounts + cartDiscount;

  /// Calcula el descuento del cupón aplicado.
  double get couponDiscount {
    if (appliedCoupon == null) return 0.0;
    return appliedCoupon!.calculateDiscount(totalPrice);
  }

  /// Calcula el precio final con cupón aplicado.
  ///
  /// `totalPrice` ya suma cada línea con el precio de oferta
  /// (`Product.finalPrice`), así que volver a restarle `totalDiscounts`
  /// cobraba el descuento dos veces: un producto con 50% de descuento
  /// terminaba en S/ 0.00. Acá solo se restan los descuentos que todavía
  /// no están metidos en el precio de línea: el del carrito y el cupón.
  double get finalPrice {
    final basePrice = totalPrice - cartDiscount;
    return (basePrice - couponDiscount).clamp(0.0, double.infinity);
  }

  /// Indica si hay un cupón aplicado.
  bool get hasCoupon => appliedCoupon != null;

  /// Crea una copia del carrito con un descuento de carrito actualizado.
  Cart withCartDiscount(double newDiscountPercentage) {
    return copyWith(
      cartDiscountPercentage: newDiscountPercentage.clamp(0.0, 100.0),
      updatedAt: DateTime.now(),
    );
  }

  /// Crea una copia del carrito con items actualizados.
  Cart withItems(List<CartItem> newItems) {
    return copyWith(
      items: newItems,
      updatedAt: DateTime.now(),
    );
  }

  /// Agrega un item al carrito o actualiza la cantidad si ya existe.
  Cart addItem(Product product, int quantity) {
    final existingIndex = items.indexWhere((item) => item.product.id.toString() == product.id.toString());
    
    if (existingIndex >= 0) {
      // Actualizar cantidad del item existente
      final updatedItems = List<CartItem>.from(items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      return withItems(updatedItems);
    } else {
      // Agregar nuevo item
      final newItem = CartItem(product: product, quantity: quantity);
      return withItems([...items, newItem]);
    }
  }

  /// Remueve un item del carrito.
  Cart removeItem(String productId) {
    final updatedItems = items.where((item) => item.product.id.toString() != productId).toList();
    return withItems(updatedItems);
  }

  /// Actualiza la cantidad de un item específico.
  Cart updateItemQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      return removeItem(productId);
    }

    final updatedItems = items.map((item) {
      if (item.product.id.toString() == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    return withItems(updatedItems);
  }

  /// Limpia todos los items del carrito (productos y combos).
  Cart clear() {
    return copyWith(
      items: [],
      comboItems: [],
      updatedAt: DateTime.now(),
    );
  }

  // MÉTODOS PARA COMBOS

  /// Agrega un combo al carrito o actualiza la cantidad si ya existe.
  Cart addCombo(Combo combo, int quantity) {
    final existingIndex = comboItems.indexWhere((item) => item.combo.id.toString() == combo.id.toString());
    
    if (existingIndex >= 0) {
      // Actualizar cantidad del combo existente
      final updatedComboItems = List<ComboCartItem>.from(comboItems);
      final existingItem = updatedComboItems[existingIndex];
      updatedComboItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      return copyWith(
        comboItems: updatedComboItems,
        updatedAt: DateTime.now(),
      );
    } else {
      // Agregar nuevo combo
      final newItem = ComboCartItem(combo: combo, quantity: quantity);
      return copyWith(
        comboItems: [...comboItems, newItem],
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Remueve un combo del carrito.
  Cart removeCombo(String comboId) {
    final updatedComboItems = comboItems.where((item) => item.combo.id.toString() != comboId).toList();
    return copyWith(
      comboItems: updatedComboItems,
      updatedAt: DateTime.now(),
    );
  }

  /// Actualiza la cantidad de un combo específico.
  Cart updateComboQuantity(String comboId, int newQuantity) {
    if (newQuantity <= 0) {
      return removeCombo(comboId);
    }

    final updatedComboItems = comboItems.map((item) {
      if (item.combo.id.toString() == comboId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    return copyWith(
      comboItems: updatedComboItems,
      updatedAt: DateTime.now(),
    );
  }
}
