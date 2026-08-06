import 'package:flutter/material.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

enum ButtonVariant { primary, secondary, tertiary, neutral }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AppDimensions dimensions;
  final ButtonVariant variant;
  final bool isOutlined;
  final double widthFactor;
  final Widget? icon;
  final bool isFullWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.dimensions,
    this.variant = ButtonVariant.primary,
    this.isOutlined = false,
    this.widthFactor = 0.6,
    this.icon,
    this.isFullWidth = false,
  });

  /// Returns the appropriate color for the button variant
  Color _getVariantColor(ColorScheme scheme) {
    switch (variant) {
      case ButtonVariant.primary:
        return scheme.primary;
      case ButtonVariant.secondary:
        return scheme.secondary;
      case ButtonVariant.tertiary:
        return scheme.tertiary;
      case ButtonVariant.neutral:
        return Colors.grey;
    }
  }

  /// Returns the color for content (text/icon) on a filled button
  Color _getOnVariantColor(ColorScheme scheme) {
    switch (variant) {
      case ButtonVariant.primary:
        return scheme.onPrimary;
      case ButtonVariant.secondary:
        return scheme.onSecondary;
      case ButtonVariant.tertiary:
        return scheme.onTertiary;
      case ButtonVariant.neutral:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final variantColor = _getVariantColor(colorScheme);
    final onVariantColor = _getOnVariantColor(colorScheme);

    final buttonChild = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              SizedBox(width: dimensions.spacingS),
              Text(
                text,
                style: AppTextStyles.button(dimensions).copyWith(
                  color: isOutlined ? variantColor : onVariantColor,
                ),
              ),
            ],
          )
        : Text(
            text,
            style: AppTextStyles.button(dimensions).copyWith(
              color: isOutlined ? variantColor : onVariantColor,
            ),
          );

    final button = isOutlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: variantColor,
              side: BorderSide(color: variantColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
              ),
            ),
            child: buttonChild,
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: variantColor,
              foregroundColor: onVariantColor,
              elevation: dimensions.blurRadius * 0.25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
              ),
            ),
            child: buttonChild,
          );

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: isFullWidth ? double.infinity : dimensions.screenWidth * widthFactor,
        height: dimensions.buttonHeight,
        child: button,
      ),
    );
  }
}
