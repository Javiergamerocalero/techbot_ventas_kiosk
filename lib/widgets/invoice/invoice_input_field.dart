import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/config/app_dimensions.dart';
import '../../styles/app_styles.dart';

/// Widget para campo de input personalizado para facturas
class InvoiceInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final String hint;
  final IconData icon;
  final AppDimensions d;
  final ColorScheme colorScheme;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool enabled;

  const InvoiceInputField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.label,
    required this.hint,
    required this.icon,
    required this.d,
    required this.colorScheme,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.maxLines,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body(d).copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: d.spacingS),
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          style: AppTextStyles.body(d).copyWith(
            color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.caption(d).copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(
              icon,
              color: colorScheme.primary,
              size: d.iconSizeM,
            ),
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            contentPadding: EdgeInsets.symmetric(
              horizontal: d.paddingM.horizontal,
              vertical: d.paddingS.vertical,
            ),
          ),
        ),
      ],
    );
  }
}
