import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/cart/coupon_dialog.dart';

/// Sección compacta de cupones
class CompactCouponSection extends ConsumerWidget {
  final Cart cart;

  const CompactCouponSection({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    if (cart.hasCoupon) {
      // Mostrar cupón aplicado de forma compacta
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.local_offer,
                  color: colorScheme.secondary,
                  size: d.iconSizeS,
                ),
                SizedBox(width: d.spacingXS),
                Expanded(
                  child: Text(
                    cart.appliedCoupon!.description,
                    style: AppTextStyles.caption(d).copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '-\$${cart.couponDiscount.toStringAsFixed(2)}',
                style: AppTextStyles.caption(d).copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: d.spacingXS),
              GestureDetector(
                onTap: () {
                  ref.read(cartNotifierProvider.notifier).removeCoupon();
                },
                child: Icon(
                  Icons.close,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  size: d.iconSizeS,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // Mostrar botón compacto para agregar cupón
      return GestureDetector(
        onTap: () => CouponDialog.show(context, ref, cart),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: d.spacingS,
            vertical: d.spacingXS,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(d.borderRadiusS),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.3),
              width: d.borderWidth,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_offer_outlined,
                color: colorScheme.primary,
                size: d.iconSizeS,
              ),
              SizedBox(width: d.spacingXS),
              Text(
                'Agregar cupón',
                style: AppTextStyles.caption(d).copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
