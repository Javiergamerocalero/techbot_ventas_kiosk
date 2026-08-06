import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/products/product_variation.dart';

part 'variation_provider.g.dart';

/// Gestiona las variaciones seleccionadas por producto
@Riverpod(keepAlive: true)
class SelectedVariation extends _$SelectedVariation {
  @override
  Map<int, int?> build() => {};
  
  /// Selecciona una variación para un producto
  void selectVariation(int productId, int? variationId) {
    state = {...state, productId: variationId};
    print('🎯 Variación seleccionada para producto $productId: $variationId');
  }
  
  /// Obtiene la variación seleccionada de un producto
  int? getSelectedVariation(int productId) => state[productId];
  
  /// Limpia la selección de un producto
  void clearSelection(int productId) {
    final newState = Map<int, int?>.from(state);
    newState.remove(productId);
    state = newState;
    print('🗑️ Selección limpiada para producto $productId');
  }
  
  /// Limpia todas las selecciones
  void clearAll() {
    state = {};
    print('🗑️ Todas las selecciones de variaciones limpiadas');
  }
}

/// Provider derivado para obtener la variación seleccionada de un producto específico
@riverpod
ProductVariation? selectedProductVariation(
  Ref ref,
  int productId,
  Product product,
) {
  final selectedId = ref.watch(selectedVariationProvider)[productId];
  
  if (selectedId == null) {
    print('ℹ️ No hay variación seleccionada para producto $productId');
    return null;
  }
  
  final variation = product.getVariationById(selectedId);
  
  if (variation == null) {
    print('⚠️ Variación $selectedId no encontrada en producto $productId');
  } else {
    print('✅ Variación encontrada: ${variation.formattedAttributes}');
  }
  
  return variation;
}

/// Provider para verificar si un producto requiere selección de variación
@riverpod
bool requiresVariationSelection(
  Ref ref,
  Product product,
) {
  if (!product.hasVariations) {
    return false;
  }
  
  final selectedId = ref.watch(selectedVariationProvider)[product.id];
  final requiresSelection = selectedId == null;
  
  if (requiresSelection) {
    print('⚠️ Producto "${product.name}" requiere selección de variación');
  }
  
  return requiresSelection;
}

/// Provider para obtener el stock de la variación seleccionada o del producto
@riverpod
int selectedVariationStock(
  Ref ref,
  int productId,
  Product product,
) {
  if (!product.hasVariations) {
    return product.effectiveStock;
  }
  
  final selectedId = ref.watch(selectedVariationProvider)[productId];
  
  if (selectedId == null) {
    // Si no hay variación seleccionada, retornar el stock total del producto
    return product.effectiveStock;
  }
  
  final variation = product.getVariationById(selectedId);
  
  if (variation == null) {
    print('⚠️ Variación $selectedId no encontrada, usando stock del producto');
    return product.effectiveStock;
  }
  
  return variation.availableStock;
}
