import 'package:flutter/material.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/models/config/payment_method.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;
  final AppDimensions dimensions;

  const PaymentMethodCard({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
    required this.dimensions,
  });

  IconData _getIconForPaymentMethod(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.niubizLane3000:
      case PaymentMethodType.niubizIm30:
        return Icons.credit_card;
      case PaymentMethodType.izipay:
        return Icons.qr_code_scanner;
      case PaymentMethodType.cashdroS:
        return Icons.payments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(dimensions.borderRadiusM),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.15)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(dimensions.borderRadiusM),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? dimensions.borderWidth * 2 : dimensions.borderWidth,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: dimensions.blurRadius * 0.5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: dimensions.spacingS,
          vertical: dimensions.spacingXS,
        ),
        child: Row(
          children: [
            // Ícono del método de pago
            Container(
              padding: EdgeInsets.all(dimensions.spacingXS),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.2)
                    : colorScheme.onSurface.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(dimensions.borderRadiusS),
              ),
              child: Icon(
                _getIconForPaymentMethod(paymentMethod.type),
                size: dimensions.iconSizeM,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(width: dimensions.spacingS),
            
            // Nombre del método de pago
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nickname principal
                  Text(
                    paymentMethod.type.nickname,
                    style: AppTextStyles.caption(dimensions).copyWith(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: dimensions.fontSizeCaption * 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Nombre técnico secundario
                  Text(
                    paymentMethod.type.displayName,
                    style: AppTextStyles.caption(dimensions).copyWith(
                      color: isSelected
                          ? colorScheme.primary.withValues(alpha: 0.7)
                          : colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w400,
                      fontSize: dimensions.fontSizeCaption * 0.85,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Indicador de selección
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: dimensions.iconSizeS,
                color: colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
