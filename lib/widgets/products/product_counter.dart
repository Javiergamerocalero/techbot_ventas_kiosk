import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class ProductCounter extends ConsumerWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool isIncrementDisabled;
  final bool isIncrementLoading;
  final bool isDecrementLoading;

  const ProductCounter({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.isIncrementDisabled = false,
    this.isIncrementLoading = false,
    this.isDecrementLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    if (quantity == 0) {
      return GestureDetector(
        onTap: (isIncrementDisabled || isIncrementLoading) ? null : onIncrement,
        child: Container(
          width: d.iconSizeL,
          height: d.iconSizeL,
          decoration: BoxDecoration(
            color: isIncrementDisabled 
                ? colorScheme.onSurface.withValues(alpha: 0.3)
                : colorScheme.primary,
            borderRadius: BorderRadius.circular(d.borderRadiusS),
            boxShadow: (isIncrementDisabled || isIncrementLoading) ? [] : [
              BoxShadow(
                color: colorScheme.onSurface.withValues(alpha: 0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: isIncrementLoading
              ? SizedBox(
                  width: d.iconSizeM,
                  height: d.iconSizeM,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isIncrementDisabled 
                          ? colorScheme.onSurface.withValues(alpha: 0.6)
                          : colorScheme.onPrimary,
                    ),
                  ),
                )
              : Icon(
                  Icons.add,
                  color: isIncrementDisabled 
                      ? colorScheme.onSurface.withValues(alpha: 0.5)
                      : colorScheme.onPrimary,
                  size: d.iconSizeM,
                ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(d.borderRadiusS),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.3),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: isDecrementLoading ? null : onDecrement,
            child: Container(
              width: d.iconSizeL,
              height: d.iconSizeL,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(d.borderRadiusS),
                  bottomLeft: Radius.circular(d.borderRadiusS),
                ),
              ),
              child: isDecrementLoading
                  ? SizedBox(
                      width: d.iconSizeM,
                      height: d.iconSizeM,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                      ),
                    )
                  : Icon(
                      Icons.remove,
                      color: colorScheme.onPrimary,
                      size: d.iconSizeM,
                    ),
            ),
          ),
          Container(
            width: d.iconSizeL,
            height: d.iconSizeL,
            color: colorScheme.primary,
            child: Center(
              child: Text(
                quantity.toString(),
                style: AppTextStyles.button(d).copyWith(
                  fontSize: d.fontSizeCaption,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (isIncrementDisabled || isIncrementLoading) ? null : onIncrement,
            child: Container(
              width: d.iconSizeL,
              height: d.iconSizeL,
              decoration: BoxDecoration(
                color: isIncrementDisabled 
                    ? colorScheme.onSurface.withValues(alpha: 0.3)
                    : colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(d.borderRadiusS),
                  bottomRight: Radius.circular(d.borderRadiusS),
                ),
              ),
              child: isIncrementLoading
                  ? SizedBox(
                      width: d.iconSizeM,
                      height: d.iconSizeM,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isIncrementDisabled 
                              ? colorScheme.onSurface.withValues(alpha: 0.6)
                              : colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.add,
                      color: isIncrementDisabled 
                          ? colorScheme.onSurface.withValues(alpha: 0.5)
                          : colorScheme.onPrimary,
                      size: d.iconSizeM,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
