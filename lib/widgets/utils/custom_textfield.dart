import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String labelText;
  final String? hintText;
  final AppDimensions dimensions;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool unfocusOnTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.dimensions,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.helperText,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.inputFormatters,
    this.textInputAction,
    this.unfocusOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveFocusNode = focusNode ?? FocusNode();

    return TextField(
      controller: controller,
      focusNode: effectiveFocusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      style: AppTextStyles.body(dimensions).copyWith(
        color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelStyle: AppTextStyles.body(dimensions).copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        hintStyle: AppTextStyles.body(dimensions).copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        errorStyle: AppTextStyles.body(dimensions).copyWith(
          color: colorScheme.error,
        ),
        helperStyle: AppTextStyles.body(dimensions).copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
        ),
        filled: true,
        fillColor: enabled 
            ? colorScheme.surfaceContainerHighest 
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        counterStyle: AppTextStyles.body(dimensions).copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
        if (unfocusOnTap && effectiveFocusNode.hasFocus) {
          effectiveFocusNode.unfocus();
        }
      },
    );
  }
}
