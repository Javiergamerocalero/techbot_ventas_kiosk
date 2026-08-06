import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/widgets/products/product_list_item.dart';

/// Widget optimizado que solo se refresca cuando cambia el stock del producto específico
class OptimizedProductListItem extends ConsumerWidget {
  final Product product;

  const OptimizedProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Solo escucha cambios del stock de este producto específico
    final currentStock = ref.watch(productCurrentStockProvider(product.id, product.effectiveStock));
    
    // Crear una copia del producto con el stock actualizado
    final productWithUpdatedStock = product.copyWith(stock: currentStock);
    
    return ProductListItem(product: productWithUpdatedStock);
  }
}
