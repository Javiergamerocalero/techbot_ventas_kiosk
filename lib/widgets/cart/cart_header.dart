import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Header del carrito con título y botón de regreso
class CartHeader extends ConsumerWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(
        top: d.screenHeight * 0.015 + d.spacingM,
        left: d.horizontalPadding,
        right: d.horizontalPadding,
        bottom: d.spacingM,
      ),
      child: Row(
        children: [
          Container(
            width: d.buttonHeight,
            height: d.buttonHeight,
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  blurRadius: d.blurRadius,
                  offset: Offset(0, d.spacingXS),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onSurface,
                size: d.iconSizeM,
              ),
            ),
          ),
          SizedBox(width: d.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tu carrito',
                  style: AppTextStyles.title(d).copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Revisa tu pedido',
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
