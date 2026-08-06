import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Estado vacío del carrito
class CartEmptyState extends ConsumerWidget {
  const CartEmptyState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: d.iconSizeL * 2,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            SizedBox(height: d.spacingL),
            Text(
              'Tu carrito está vacío',
              style: AppTextStyles.subtitle(d),
            ),
            SizedBox(height: d.spacingS),
            Text(
              'Agrega productos o combos para continuar',
              style: AppTextStyles.caption(d),
            ),
          ],
        ),
      ),
    );
  }
}
