import 'package:flutter/material.dart';
import '../../models/config/app_dimensions.dart';
import '../../styles/app_styles.dart';

/// Widget para mostrar el estado de validación (loading, success, error)
class InvoiceValidationDisplay extends StatelessWidget {
  final AppDimensions d;
  final ColorScheme colorScheme;
  final bool isValidating;
  final bool isValidated;
  final String? validationError;
  final String? validatedData;
  final String? additionalData;
  final String validatingMessage;
  final String validatedTitle;

  const InvoiceValidationDisplay({
    super.key,
    required this.d,
    required this.colorScheme,
    required this.isValidating,
    required this.isValidated,
    required this.validationError,
    this.validatedData,
    this.additionalData,
    required this.validatingMessage,
    required this.validatedTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Loading state
        if (isValidating) ...[
          SizedBox(height: d.spacingS),
          Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: d.spacingS),
              Text(
                validatingMessage,
                style: AppTextStyles.caption(d).copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],

        // Success state
        if (isValidated && validatedData != null && validatedData!.isNotEmpty) ...[
          SizedBox(height: d.spacingS),
          Container(
            padding: EdgeInsets.all(d.spacingS),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              border: Border.all(color: Colors.green),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: d.iconSizeS),
                    SizedBox(width: d.spacingS),
                    Expanded(
                      child: Text(
                        validatedTitle,
                        style: AppTextStyles.caption(d).copyWith(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: d.spacingXS),
                Text(
                  validatedData!,
                  style: AppTextStyles.caption(d).copyWith(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (additionalData != null && additionalData!.isNotEmpty) ...[
                  Text(
                    additionalData!,
                    style: AppTextStyles.caption(d).copyWith(
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],

        // Error state
        if (validationError != null) ...[
          SizedBox(height: d.spacingS),
          Container(
            padding: EdgeInsets.all(d.spacingS),
            decoration: BoxDecoration(
              color: colorScheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              border: Border.all(color: colorScheme.error),
            ),
            child: Row(
              children: [
                Icon(Icons.error, color: colorScheme.error, size: d.iconSizeS),
                SizedBox(width: d.spacingS),
                Expanded(
                  child: Text(
                    validationError!,
                    style: AppTextStyles.caption(d).copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
