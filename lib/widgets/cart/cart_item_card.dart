import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/cart/cart_item.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/product_counter.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/providers/ui/stock_warning_provider.dart';
/// Card individual de producto en el carrito
class CartItemCard extends ConsumerWidget {
  final CartItem item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  /// Incrementa la cantidad usando el endpoint
  Future<void> _incrementProduct(BuildContext context, WidgetRef ref) async {
    final key = 'cart_product_${item.product.id}_inc';
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(key, () async {
        final newQuantity = item.quantity + 1;
        final variationId = item.selectedVariation?.id;
        
        final response = await ref.read(cartNotifierProvider.notifier).validateStockOnly(
          item.product, 
          newQuantity,
          variationId: variationId,
        );
        
        if (response.isAvailable) {
          ref.read(cartNotifierProvider.notifier).updateQuantity(
            item.product.id.toString(), 
            newQuantity,
            variationId: variationId,
          );
        } else {
          // Modal amigable UNA sola vez por producto
          final warning = ref.read(stockWarningProvider.notifier);
          final warnKey = 'product_${item.product.id}';
          if (!warning.hasShownWarning(warnKey)) {
            if (context.mounted) {
              await StockValidationModal.showOutOfStock(
                context: context,
                productName: item.product.name,
              );
            }
            warning.markWarningShown(warnKey);
          }
        }
      });
    } catch (_) {}
  }

  /// Decrementa la cantidad usando el endpoint
  Future<void> _decrementProduct(BuildContext context, WidgetRef ref) async {
    final key = 'cart_product_${item.product.id}_dec';
    try {
      final newQuantity = item.quantity - 1;
      final variationId = item.selectedVariation?.id;
      
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(key, () async {
        if (newQuantity <= 0) {
          await _removeProduct(context, ref);
          return;
        }

        // 1) Actualizar carrito localmente primero
        ref.read(cartNotifierProvider.notifier).updateQuantity(
          item.product.id.toString(), 
          newQuantity,
          variationId: variationId,
        );

        // 2) Aumentar optimistamente el stock local para reflejar disponibilidad inmediata
        if (variationId != null) {
          // Actualizar stock de variación específica
          final currentStock = ref.read(currentProductVariationStockProvider(item.product.id, variationId));
          final stockMap = ref.read(productVariationStockMapProvider);
          final key = '${item.product.id}_$variationId';
          ref.read(productVariationStockMapProvider.notifier).state = {
            ...stockMap,
            key: currentStock + 1,
          };
        } else {
          // Actualizar stock del producto general
          final currentStock = ref.read(currentProductStockProvider(item.product.id));
          final stockMap = ref.read(productStockMapProvider);
          ref.read(productStockMapProvider.notifier).state = {
            ...stockMap,
            item.product.id: currentStock + 1,
          };
        }

        // 3) Sincronizar con el backend (mantener overlay hasta terminar)
        try {
          final resp = await ref.read(cartNotifierProvider.notifier).validateStockOnly(
            item.product, 
            newQuantity,
            variationId: variationId,
          );
          if (resp.isAvailable && resp.additionalData != null) {
            final stockAvailable = resp.additionalData!['stock_available'] as int?;
            if (stockAvailable != null) {
              final currentMap = ref.read(productStockMapProvider);
              ref.read(productStockMapProvider.notifier).state = {
                ...currentMap,
                item.product.id: stockAvailable,
              };
            }
          }
        } catch (_) {}
      });
    } catch (_) {}
  }

  /// Elimina el producto usando el endpoint
  Future<void> _removeProduct(BuildContext context, WidgetRef ref) async {
    try {
      // Mostrar loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      
      // Obtener variation_id si existe
      final variationId = item.selectedVariation?.id;
      
      final response = await ref.read(
        removeProductFromCartProvider(item.product.id, variationId: variationId).future
      );
      
      // Cerrar loading
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      
      if (response.isAvailable) {
        ref.read(cartNotifierProvider.notifier).removeProduct(item.product.id.toString());
      } else {
        if (context.mounted) {
          StockValidationModal.show(
            context: context,
            title: 'Error eliminando producto',
            message: response.message,
            isSuccess: false,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    
    // CRÍTICO: Usar stock actualizado para validación
    final currentStock = ref.watch(currentProductStockProvider(item.product.id));

    return Container(
      margin: EdgeInsets.only(bottom: d.spacingM),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(d.borderRadiusM),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: d.spacingS,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(d.spacingM),
        child: Row(
          children: [
            // Imagen del producto
            Container(
              width: d.screenWidth * 0.20,
              height: d.screenWidth * 0.16, // Altura rectangular como en ProductsScreen
              decoration: BoxDecoration(
                color: Colors.white, // Fondo blanco para mejor contraste
                borderRadius: BorderRadius.circular(d.borderRadiusS),
              ),
              child: CachedProductImage(
                product: item.product,
                width: double.infinity,
                height: d.screenWidth * 0.16,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(d.borderRadiusS),
              ),
            ),
            SizedBox(width: d.spacingM),
            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: AppTextStyles.subtitle(d),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Mostrar variación si existe
                            if (item.hasVariation) ...[
                              SizedBox(height: d.spacingXS * 0.5),
                              Text(
                                item.selectedVariation!.formattedAttributes,
                                style: AppTextStyles.caption(d).copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            SizedBox(height: d.spacingXS),
                            Text(
                              item.product.formattedPrice,
                              style: AppTextStyles.price(d),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeProduct(context, ref),
                        icon: Icon(
                          Icons.delete_outline,
                          color: colorScheme.error,
                          size: d.iconSizeM,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: d.spacingS),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${item.product.currencySymbol}${item.totalPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.body(d).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ProductCounter(
                        quantity: item.quantity,
                        isIncrementDisabled: currentStock <= 0,
                        onIncrement: () => _incrementProduct(context, ref),
                        onDecrement: () => _decrementProduct(context, ref),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
