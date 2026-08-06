import 'package:flutter/material.dart';
import '../../models/config/app_dimensions.dart';
import '../../models/config/invoice_type.dart';
import '../../styles/app_styles.dart';

/// Widget para mostrar un card de tipo de comprobante clickeable
class InvoiceTypeCard extends StatelessWidget {
  final AppDimensions d;
  final ColorScheme colorScheme;
  final InvoiceType type;
  final IconData icon;
  final VoidCallback onTap;

  const InvoiceTypeCard({
    super.key,
    required this.d,
    required this.colorScheme,
    required this.type,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(d.borderRadiusM),
      child: Container(
        padding: EdgeInsets.all(d.spacingM),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(d.borderRadiusM),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: d.blurRadius * 0.5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: d.iconSizeL,
              height: d.iconSizeL,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: colorScheme.primary,
                size: d.iconSizeM,
              ),
            ),
            SizedBox(width: d.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.displayName,
                    style: AppTextStyles.body(d).copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: d.spacingXS * 0.5),
                  Text(
                    type.description,
                    style: AppTextStyles.caption(d).copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: colorScheme.onSurface.withValues(alpha: 0.4),
              size: d.iconSizeS,
            ),
          ],
        ),
      ),
    );
  }
}
