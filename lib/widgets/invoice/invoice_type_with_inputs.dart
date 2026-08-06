import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/config/app_dimensions.dart';
import '../../models/config/invoice_type.dart';
import '../../styles/app_styles.dart';
import 'invoice_input_field.dart';
import 'invoice_validation_display.dart';

/// Widget para mostrar un tipo de comprobante con sus inputs correspondientes
class InvoiceTypeWithInputs extends StatelessWidget {
  final AppDimensions d;
  final ColorScheme colorScheme;
  final InvoiceType type;
  final IconData icon;
  final TextEditingController? dniController;
  final TextEditingController? rucController;
  final FocusNode? dniFocusNode;
  final FocusNode? rucFocusNode;
  final bool isValidating;
  final bool isValidated;
  final String? validationError;
  final String dniFullName;
  final String razonSocial;
  final String direccion;

  const InvoiceTypeWithInputs({
    super.key,
    required this.d,
    required this.colorScheme,
    required this.type,
    required this.icon,
    this.dniController,
    this.rucController,
    this.dniFocusNode,
    this.rucFocusNode,
    required this.isValidating,
    required this.isValidated,
    required this.validationError,
    required this.dniFullName,
    required this.razonSocial,
    required this.direccion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(d.spacingM),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(d.borderRadiusM),
        border: Border.all(
          color: colorScheme.primary,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: d.blurRadius,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del tipo seleccionado
          Row(
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
              Container(
                padding: EdgeInsets.all(d.spacingXS),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: colorScheme.primary,
                  size: d.iconSizeS,
                ),
              ),
            ],
          ),
          SizedBox(height: d.spacingM),

          // Inputs según el tipo
          if (type == InvoiceType.boletaWithDNI && dniController != null) ...[
            InvoiceInputField(
              controller: dniController!,
              focusNode: dniFocusNode,
              label: 'DNI',
              hint: 'Ingrese 8 dígitos para validar',
              icon: Icons.badge,
              keyboardType: TextInputType.number,
              maxLength: 8,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              enabled: !isValidating,
              d: d,
              colorScheme: colorScheme,
            ),
            InvoiceValidationDisplay(
              d: d,
              colorScheme: colorScheme,
              isValidating: isValidating,
              isValidated: isValidated,
              validationError: validationError,
              validatedData: dniFullName,
              validatingMessage: 'Validando DNI...',
              validatedTitle: 'DNI Validado',
            ),
          ],

          if (type == InvoiceType.facturaElectronica && rucController != null) ...[
            InvoiceInputField(
              controller: rucController!,
              focusNode: rucFocusNode,
              label: 'RUC',
              hint: 'Ingrese 11 dígitos para validar',
              icon: Icons.business,
              keyboardType: TextInputType.number,
              maxLength: 11,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              enabled: !isValidating,
              d: d,
              colorScheme: colorScheme,
            ),
            InvoiceValidationDisplay(
              d: d,
              colorScheme: colorScheme,
              isValidating: isValidating,
              isValidated: isValidated,
              validationError: validationError,
              validatedData: razonSocial.isNotEmpty ? 'Razón Social: $razonSocial' : null,
              additionalData: direccion.isNotEmpty ? 'Dirección: $direccion' : null,
              validatingMessage: 'Validando RUC...',
              validatedTitle: 'RUC Validado',
            ),
          ],
        ],
      ),
    );
  }
}
