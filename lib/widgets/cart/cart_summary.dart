import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/cart/compact_coupon_section.dart';

/// Resumen de compra compacto
class CartSummary extends ConsumerWidget {
  final Cart cart;
  final int totalItems;

  const CartSummary({
    super.key,
    required this.cart,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    
    // Obtener símbolo de moneda del primer item (productos o combos)
    String currencySymbol = 'PEN'; // Fallback
    if (cart.items.isNotEmpty) {
      currencySymbol = cart.items.first.product.currencySymbol;
    } else if (cart.comboItems.isNotEmpty) {
      currencySymbol = cart.comboItems.first.combo.currencySymbol;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: d.horizontalPadding,
        vertical: d.spacingM,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: d.spacingS,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila compacta: Productos y Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalItems productos',
                style: AppTextStyles.caption(d).copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                'Subtotal: $currencySymbol${cart.subtotal.toStringAsFixed(2)}',
                style: AppTextStyles.caption(d).copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          
          // Descuentos (si existen)
          if (cart.productDiscounts > 0) ...[
            SizedBox(height: d.spacingXS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Descuentos',
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                Text(
                  '-$currencySymbol${cart.productDiscounts.toStringAsFixed(2)}',
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
          // Sección de cupón compacta
          SizedBox(height: d.spacingS),
          CompactCouponSection(cart: cart),
          
          // Divider más delgado
          Divider(
            height: d.spacingM,
            thickness: 1,
            color: colorScheme.onSurface.withValues(alpha: 0.2),
          ),
          
          // Total y botón en la misma fila
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: AppTextStyles.caption(d).copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      '$currencySymbol${cart.finalPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.price(d).copyWith(
                        fontSize: d.fontSizeTitle * 0.9,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: d.spacingM),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/payment-confirmation');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: EdgeInsets.symmetric(vertical: d.spacingS),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(d.borderRadiusM),
                    ),
                  ),
                  child: Text(
                    'Continuar',
                    style: AppTextStyles.button(d).copyWith(
                      fontSize: d.fontSizeBody,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
