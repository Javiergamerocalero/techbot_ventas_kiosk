import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/products/product_variation.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/models/cart/cart_item.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/combos/combo_cart_item.dart';
import 'package:ventas_kiosko/models/coupon/coupon.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/models/products/stock_response.dart';

part 'cart_provider.g.dart';


@Riverpod(keepAlive: true)
class CartNotifier extends _$CartNotifier {
  @override
  Cart build() => const Cart();

  /// Valida el stock y agrega un producto al carrito
  Future<StockResponse> validateAndAddProduct(
    Product product, {
    int quantity = 1,
    ProductVariation? selectedVariation,
  }) async {
    // Usar SKU de variación si existe y no es null, sino SKU del producto
    final variationSku = selectedVariation?.sku;
    final skuToValidate = (variationSku != null && variationSku.isNotEmpty) 
        ? variationSku 
        : product.sku;
    
    print('📍 CartProvider: Validando stock para SKU: $skuToValidate (Variación: ${selectedVariation?.formattedAttributes ?? "ninguna"})');
    
    // Validar stock antes de agregar (incluir variation_id si existe)
    final stockResponse = await ref.read(
      validateProductStockProvider(
        product.id, 
        quantity,
        variationId: selectedVariation?.id,
      ).future,
    );
    
    if (stockResponse.isAvailable) {
      // Si hay stock disponible, agregar al carrito
      addProduct(product, quantity: quantity, selectedVariation: selectedVariation);
      print('✅ CartProvider: Producto agregado con variación: ${selectedVariation?.formattedAttributes ?? "ninguna"}');
    } else {
      // Si no hay stock disponible, actualizar el stock local
      final stockAvailable = stockResponse.availableStock;
      if (selectedVariation != null) {
        // Actualizar stock de la variación específica
        print('📊 CartProvider: Actualizando stock de variación ${selectedVariation.id} a $stockAvailable');
        updateProductVariationStockHelper(ref, product.id, selectedVariation.id, stockAvailable);
      } else {
        // Actualizar stock del producto general
        updateProductStockHelper(ref, product.id, stockAvailable);
      }
      
      print('🔄 CartProvider: Stock actualizado para ${product.name} - Stock disponible: $stockAvailable');
    }
    
    return stockResponse;
  }

  /// Valida el stock para una cantidad específica actualizando el backend
  Future<StockResponse> validateStockOnly(
    Product product, 
    int totalQuantity, {
    int? variationId,
  }) async {
    try {
      final stockService = ref.read(stockServiceProvider);
      final response = await stockService.checkProductStock(
        product.id, 
        totalQuantity,
        variationId: variationId,
      );
      
      // Si no hay stock disponible, actualizar el stock local usando el helper correspondiente
      if (!response.isAvailable) {
        final stockAvailable = response.availableStock;
        
        if (variationId != null) {
          // Actualizar stock de la variación específica
          updateProductVariationStockHelper(ref, product.id, variationId, stockAvailable);
          print('🔄 CartProvider: Stock de variación actualizado en validateStockOnly - Producto: ${product.name}, Variación: $variationId, Stock: $stockAvailable');
        } else {
          // Actualizar stock del producto general
          updateProductStockHelper(ref, product.id, stockAvailable);
          print('🔄 CartProvider: Stock actualizado en validateStockOnly para ${product.name} - Stock disponible: $stockAvailable');
        }
      }
      
      return response;
    } catch (e) {
      print('❌ CartProvider: Error validando stock para ${product.name}: $e');
      rethrow;
    }
  }

  /// Agrega un producto al carrito o incrementa su cantidad si ya existe
  void addProduct(
    Product product, {
    int quantity = 1,
    ProductVariation? selectedVariation,
  }) {
    // Verificar stock local antes de agregar
    final stockMap = ref.read(productStockMapProvider);
    final localStock = stockMap[product.id] ?? product.effectiveStock;
    if (localStock == 0) {
      return;
    }
    
    // Buscar si ya existe el mismo producto con la misma variación
    final existingItemIndex = state.items.indexWhere(
      (item) => 
        item.product.id.toString() == product.id.toString() &&
        item.selectedVariation?.id == selectedVariation?.id,
    );

    if (existingItemIndex >= 0) {
      // Si el producto con la misma variación ya existe, incrementar cantidad
      final existingItem = state.items[existingItemIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingItemIndex] = updatedItem;
      
      state = state.copyWith(
        items: updatedItems,
        updatedAt: DateTime.now(),
      );
      print('🔄 CartProvider: Cantidad actualizada para ${product.name} (${selectedVariation?.formattedAttributes ?? "sin variación"})');
    } else {
      // Si es un producto nuevo o con diferente variación, agregarlo
      final newItem = CartItem(
        product: product,
        quantity: quantity,
        selectedVariation: selectedVariation,
        addedAt: DateTime.now(),
      );
      
      state = state.copyWith(
        items: [...state.items, newItem],
        updatedAt: DateTime.now(),
      );
      print('➕ CartProvider: Nuevo item agregado: ${product.name} (${selectedVariation?.formattedAttributes ?? "sin variación"})');
    }
  }

  /// Actualiza la cantidad de un producto específico
  /// Si el producto tiene variaciones, debe especificarse variationId para actualizar el item correcto
  void updateQuantity(String productId, int newQuantity, {int? variationId}) {
    if (newQuantity <= 0) {
      removeProduct(productId, variationId: variationId);
      return;
    }

    final updatedItems = state.items.map((item) {
      // Verificar que coincida el productId Y la variación (si se especificó)
      final matchesProduct = item.product.id.toString() == productId;
      final matchesVariation = variationId == null || item.selectedVariation?.id == variationId;
      
      if (matchesProduct && matchesVariation) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    state = state.copyWith(
      items: updatedItems,
      updatedAt: DateTime.now(),
    );
  }

  /// Incrementa la cantidad de un producto
  void incrementQuantity(String productId) {
    final item = state.items.firstWhere(
      (item) => item.product.id.toString() == productId,
    );
    updateQuantity(productId, item.quantity + 1);
  }

  /// Decrementa la cantidad de un producto
  void decrementQuantity(String productId) {
    final item = state.items.firstWhere(
      (item) => item.product.id.toString() == productId,
    );
    updateQuantity(productId, item.quantity - 1);
  }

  /// Elimina un producto del carrito
  /// Si el producto tiene variaciones, debe especificarse variationId para eliminar el item correcto
  void removeProduct(String productId, {int? variationId}) {
    final updatedItems = state.items.where((item) {
      final matchesProduct = item.product.id.toString() == productId;
      final matchesVariation = variationId == null || item.selectedVariation?.id == variationId;
      
      // Mantener el item si NO coincide con el producto Y variación a eliminar
      return !(matchesProduct && matchesVariation);
    }).toList();

    state = state.copyWith(
      items: updatedItems,
      updatedAt: DateTime.now(),
    );
  }

  /// Limpia todo el carrito
  void clearCart() {
    state = const Cart(
      items: [],
      comboItems: [],
      cartDiscountPercentage: 0.0,
      appliedCoupon: null,
      updatedAt: null,
    );
  }

  /// Limpia el carrito y repone el stock en el backend
  Future<StockResponse> clearCartWithBackend() async {
    // Llamar al endpoint para limpiar carrito y reponer stock
    final response = await ref.read(clearCartAndRestoreStockProvider.future);
    
    if (response.isAvailable) {
      // Si la limpieza en backend es exitosa, limpiar carrito local
      state = const Cart(
        items: [],
        comboItems: [],
        cartDiscountPercentage: 0.0,
        appliedCoupon: null,
        updatedAt: null,
      );
    }
    
    return response;
  }

  /// Aplica descuento a nivel de carrito
  void applyCartDiscount(double discountPercentage) {
    state = state.copyWith(
      cartDiscountPercentage: discountPercentage,
      updatedAt: DateTime.now(),
    );
  }

  // MÉTODOS PARA COMBOS

  /// Valida el stock y agrega un combo al carrito
  Future<StockResponse> validateAndAddCombo(Combo combo, {int quantity = 1}) async {
    // Validar stock antes de agregar
    final stockResponse = await ref.read(updateComboStockProvider(combo.id, quantity).future);
    
    if (stockResponse.isAvailable) {
      // Si hay stock disponible, agregar al carrito local
      addCombo(combo, quantity: quantity);
    }
    
    return stockResponse;
  }

  /// Agrega un combo al carrito (solo local)
  void addCombo(Combo combo, {int quantity = 1}) {
    state = state.addCombo(combo, quantity);
  }

  /// Actualiza la cantidad de un combo en el carrito con validación de stock
  Future<StockResponse> updateComboQuantity(String comboId, int newQuantity) async {
    // Verificar estado actual del carrito
    final currentCombo = state.comboItems.where((item) => item.combo.id.toString() == comboId).firstOrNull;
    
    try {
      // Llamar al endpoint para actualizar combo y validar stock
      final response = await ref.read(updateComboStockProvider(int.parse(comboId), newQuantity).future);
      
      if (response.isAvailable) {
        // Si la actualización es exitosa, actualizar carrito local SOLO si el combo ya existe
        if (currentCombo != null) {
          state = state.updateComboQuantity(comboId, newQuantity);
        }
        // Si el combo no existe, debe agregarse desde el widget que tiene acceso al objeto Combo
      }
      
      return response;
      
    } catch (e) {
      print('💥 CartProvider: Error actualizando combo $comboId: $e');
      rethrow;
    }
  }

  /// Actualiza la cantidad de un combo con variaciones seleccionadas
  Future<StockResponse> updateComboQuantityWithVariations(
    String comboId,
    int newQuantity,
    Map<int, int> selectedVariations,
  ) async {
    print('🎯 CartProvider: Agregando combo $comboId con variaciones');
    print('📋 CartProvider: Variaciones seleccionadas: $selectedVariations');
    
    final currentCombo = state.comboItems.where((item) => item.combo.id.toString() == comboId).firstOrNull;
    
    try {
      // Llamar al endpoint con variaciones
      final response = await ref.read(
        updateComboStockWithVariationsProvider(
          int.parse(comboId),
          newQuantity,
          selectedVariations,
        ).future,
      );
      
      if (response.isAvailable) {
        print('✅ CartProvider: Combo con variaciones agregado exitosamente');
        if (currentCombo != null) {
          state = state.updateComboQuantity(comboId, newQuantity);
        }
      } else {
        print('❌ CartProvider: Error al agregar combo: ${response.message}');
      }
      
      return response;
    } catch (e) {
      print('💥 CartProvider: Error agregando combo con variaciones: $e');
      return const StockResponse(
        isAvailable: false,
        availableStock: 0,
        message: 'Error al agregar combo con variaciones',
      );
    }
  }

  /// Remueve un combo del carrito
  void removeCombo(String comboId) {
    state = state.removeCombo(comboId);
  }

  // MÉTODOS PARA CUPONES

  /// Aplica un cupón al carrito
  void applyCoupon(Coupon coupon) {
    state = state.copyWith(
      appliedCoupon: coupon,
      updatedAt: DateTime.now(),
    );
  }

  /// Remueve el cupón aplicado
  void removeCoupon() {
    state = state.copyWith(
      appliedCoupon: null,
      updatedAt: DateTime.now(),
    );
  }
}

/// Provider para obtener la cantidad total de items en el carrito (productos + combos)
@Riverpod(keepAlive: false)
int cartTotalItems(Ref ref) {
  final cart = ref.watch(cartNotifierProvider);
  return cart.totalItems; // Usa el getter que incluye productos y combos
}

/// Obtener el precio total del carrito
@Riverpod(keepAlive: false)
double cartTotalPrice(Ref ref) {
  final cart = ref.watch(cartNotifierProvider);
  return cart.totalPrice;
}

/// Para verificar si un producto está en el carrito
@Riverpod(keepAlive: false)
CartItem? productInCart(Ref ref, String productId) {
  final cart = ref.watch(cartNotifierProvider);
  try {
    return cart.items.firstWhere((item) => item.product.id.toString() == productId);
  } catch (e) {
    return null;
  }
}

/// Para verificar si un combo está en el carrito
@Riverpod(keepAlive: false)
ComboCartItem? comboInCart(Ref ref, String comboId) {
  final cart = ref.watch(cartNotifierProvider);
  try {
    return cart.comboItems.firstWhere((item) => item.combo.id.toString() == comboId);
  } catch (e) {
    return null;
  }
}
