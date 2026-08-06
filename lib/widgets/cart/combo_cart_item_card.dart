import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/combos/combo_cart_item.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/product_counter.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/widgets/images/cached_combo_image.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/providers/ui/stock_warning_provider.dart';

/// Card individual de combo en el carrito
class ComboCartItemCard extends ConsumerWidget {
  final ComboCartItem item;

  const ComboCartItemCard({
    super.key,
    required this.item,
  });

  Future<void> _incrementCombo(BuildContext context, WidgetRef ref) async {
    final key = 'cart_combo_${item.combo.id}_inc';
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(key, () async {
        final newQuantity = item.quantity + 1;
        final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(item.combo.id.toString(), newQuantity);
        if (!response.isAvailable) {
          final warning = ref.read(stockWarningProvider.notifier);
          final warnKey = 'combo_${item.combo.id}';
          if (!warning.hasShownWarning(warnKey)) {
            if (context.mounted) {
              await StockValidationModal.showOutOfStock(
                context: context,
                productName: item.combo.name,
              );
            }
            warning.markWarningShown(warnKey);
          }
        }
      });
    } catch (_) {}
  }

  Future<void> _decrementCombo(BuildContext context, WidgetRef ref) async {
    if (item.quantity > 1) {
      final key = 'cart_combo_${item.combo.id}_dec';
      try {
        await ref.read(buttonLoadingProvider.notifier).executeWithLoading(key, () async {
          final newQuantity = item.quantity - 1;
          final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(item.combo.id.toString(), newQuantity);
          if (!response.isAvailable && context.mounted) {
            StockValidationModal.show(
              context: context,
              title: 'Error',
              message: response.message,
              isSuccess: false,
            );
          }
        });
      } catch (_) {}
    }
  }

  Future<void> _removeCombo(BuildContext context, WidgetRef ref) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      
      final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(item.combo.id.toString(), 0);
      
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      
      if (!response.isAvailable && context.mounted) {
        StockValidationModal.show(
          context: context,
          title: 'Error eliminando combo',
          message: response.message,
          isSuccess: false,
        );
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

    return Container(
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
      child: Row(
        children: [
          // Imagen del combo
          Container(
            width: d.screenWidth * 0.20,
            height: d.screenWidth * 0.16, // Altura rectangular como en ProductsScreen
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco para mejor contraste
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(d.borderRadiusM),
                bottomLeft: Radius.circular(d.borderRadiusM),
              ),
            ),
            child: CachedComboImage(
              combo: item.combo,
              width: double.infinity,
              height: d.screenWidth * 0.16,
              fit: BoxFit.contain,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(d.borderRadiusM),
                bottomLeft: Radius.circular(d.borderRadiusM),
              ),
            ),
          ),
          // Información del combo
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(d.spacingM),
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
                              item.combo.name,
                              style: AppTextStyles.cardTitleSmall(d),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: d.spacingXS),
                            Text(
                              item.combo.formattedPrice,
                              style: AppTextStyles.price(d),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeCombo(context, ref),
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
                        'Total: ${item.combo.currencySymbol}${item.totalPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.subtitle(d).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ProductCounter(
                        quantity: item.quantity,
                        onIncrement: () => _incrementCombo(context, ref),
                        onDecrement: () => _decrementCombo(context, ref),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
