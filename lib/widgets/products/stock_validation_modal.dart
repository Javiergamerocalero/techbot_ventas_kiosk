import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Modal que muestra información sobre la validación de stock.
/// Se usa tanto para éxito como para errores de disponibilidad.
class StockValidationModal extends ConsumerWidget {
  final String title;
  final String message;
  final bool isSuccess;
  final bool isWarning;
  final VoidCallback? onConfirm;

  const StockValidationModal({
    super.key,
    required this.title,
    required this.message,
    this.isSuccess = false,
    this.isWarning = false,
    this.onConfirm,
  });

  /// Muestra el modal de validación de stock
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    bool isSuccess = false,
    bool isWarning = false,
    VoidCallback? onConfirm,
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.35),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => StockValidationModal(
        title: title,
        message: message,
        isSuccess: isSuccess,
        isWarning: isWarning,
        onConfirm: onConfirm,
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.3),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          )),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.8,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              )),
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// Muestra modal de éxito cuando se agrega un producto al carrito
  static Future<void> showSuccess({
    required BuildContext context,
    required String productName,
  }) {
    return show(
      context: context,
      title: '¡Agregado al carrito!',
      message: '$productName se agregó correctamente a tu pedido',
      isSuccess: true,
    );
  }

  /// Muestra modal de error cuando no hay stock disponible
  static Future<void> showOutOfStock({
    required BuildContext context,
    required String productName,
    String? customMessage,
  }) {
    return show(
      context: context,
      title: 'Uppss! ',
      message: customMessage ?? 'Te pedimos disculpas, alguien se adelantó y "$productName" quedó sin stock.\n\nPronto volverá a estar disponible.',
      isSuccess: false,
      isWarning: true,
    );
  }

  /// Muestra modal de error cuando hay stock insuficiente
  static Future<void> showInsufficientStock({
    required BuildContext context,
    required String productName,
    required int availableStock,
  }) {
    return show(
      context: context,
      title: 'Stock insuficiente',
      message: 'Solo quedan $availableStock unidades de "$productName" disponibles',
      isSuccess: false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    // Paleta base según estado
    final baseColor = isSuccess
        ? colorScheme.primary
        : (isWarning ? colorScheme.secondary : colorScheme.error);
    final onBaseColor = isSuccess
        ? colorScheme.onPrimary
        : (isWarning ? colorScheme.onSecondary : colorScheme.onError);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
      child: Container(
        width: d.screenWidth * 0.7, // Más compacto
        constraints: BoxConstraints(
          maxWidth: d.screenWidth * 0.8, // Más compacto
          minHeight: d.screenHeight * 0.18, // Más compacto
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(d.borderRadiusL),
          boxShadow: [
            // Sombra principal responsiva
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: d.blurRadius,
              offset: Offset(0, d.spacingS),
              spreadRadius: 0,
            ),
            // Sombra secundaria
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: d.blurRadius * 0.25,
              offset: Offset(0, d.spacingXS),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(d.borderRadiusL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header con color de fondo
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(d.spacingL, d.spacingL, d.spacingL, d.spacingM),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      baseColor.withValues(alpha: 0.06),
                      colorScheme.surface,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Icono responsivo
                    Container(
                      width: d.iconSizeL * 1.6,
                      height: d.iconSizeL * 1.6,
                      decoration: BoxDecoration(
                        color: baseColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: baseColor.withValues(alpha: 0.2),
                          width: d.borderWidth,
                        ),
                      ),
                      child: Icon(
                        isSuccess ? Icons.check_circle_rounded : Icons.info_rounded,
                        color: baseColor,
                        size: d.iconSizeL,
                      ),
                    ),
                    
                    SizedBox(height: d.spacingM),
                    
                    // Título responsivo
                    Text(
                      title,
                      style: AppTextStyles.title(d).copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Body con mensaje
              Padding(
                padding: EdgeInsets.fromLTRB(d.spacingL, 0, d.spacingL, d.spacingL),
                child: Column(
                  children: [
                    // Mensaje responsivo
                    Text(
                      message,
                      style: AppTextStyles.body(d).copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: d.spacingL),
                    
                    // Botón responsivo
                    SizedBox(
                      width: double.infinity,
                      height: d.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          foregroundColor: onBaseColor,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(d.borderRadiusM),
                          ),
                        ),
                        child: Text(
                          'Entendido',
                          style: AppTextStyles.button(d),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
