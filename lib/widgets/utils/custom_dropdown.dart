import 'package:flutter/material.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String labelText;
  final String? hintText;
  final AppDimensions dimensions;
  final String Function(T)? itemLabel;
  final Widget? prefixIcon;
  final String? errorText;
  final String? helperText;
  final bool enabled;
  final double? width;
  final bool isExpanded;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.labelText,
    required this.dimensions,
    this.hintText,
    this.itemLabel,
    this.prefixIcon,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.width,
    this.isExpanded = true,
  });

  String _getItemLabel(T item) {
    if (itemLabel != null) {
      return itemLabel!(item);
    }
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              _getItemLabel(item),
              style: AppTextStyles.body(
                dimensions,
              ).copyWith(color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5)),
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        isExpanded: isExpanded,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          helperText: helperText,
          prefixIcon: prefixIcon,
          labelStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
          hintStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5)),
          errorStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.error),
          helperStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: dimensions.paddingM.horizontal,
            vertical: dimensions.paddingS.vertical,
          ),
        ),
        style: AppTextStyles.body(
          dimensions,
        ).copyWith(color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5)),
        dropdownColor: colorScheme.surfaceContainerHighest,
        icon: Icon(
          Icons.arrow_drop_down,
          color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        elevation: 8,
        borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
      ),
    );
  }
}

/// A more modern alternative using DropdownMenu (Flutter 3.7+)
class CustomDropdownMenu<T> extends StatelessWidget {
  final T? initialSelection;
  final List<T> items;
  final ValueChanged<T?> onSelected;
  final String labelText;
  final String? hintText;
  final AppDimensions dimensions;
  final String Function(T)? itemLabel;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? errorText;
  final String? helperText;
  final bool enabled;
  final double? width;
  final TextEditingController? controller;

  const CustomDropdownMenu({
    super.key,
    required this.initialSelection,
    required this.items,
    required this.onSelected,
    required this.labelText,
    required this.dimensions,
    this.hintText,
    this.itemLabel,
    this.leadingIcon,
    this.trailingIcon,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.width,
    this.controller,
  });

  String _getItemLabel(T item) {
    if (itemLabel != null) {
      return itemLabel!(item);
    }
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DropdownMenu<T>(
      initialSelection: initialSelection,
      controller: controller,
      enabled: enabled,
      width: width,
      label: Text(labelText),
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      onSelected: onSelected,
      dropdownMenuEntries: items.map((T item) {
        return DropdownMenuEntry<T>(
          value: item,
          label: _getItemLabel(item),
          style: MenuItemButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            textStyle: AppTextStyles.body(dimensions),
          ),
        );
      }).toList(),
      textStyle: AppTextStyles.body(
        dimensions,
      ).copyWith(color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withValues(alpha: 0.5)),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
        hintStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5)),
        errorStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.error),
        helperStyle: AppTextStyles.body(dimensions).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
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
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainerHighest),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(dimensions.borderRadiusS)),
        ),
        minimumSize: width != null ? WidgetStateProperty.all(Size(width!, 0)) : null,
        maximumSize: width != null ? WidgetStateProperty.all(Size(width!, double.infinity)) : null,
      ),
    );
  }
}
