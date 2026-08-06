import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/coupon/coupon_provider.dart';
import 'package:ventas_kiosko/services/coupon_service.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/utils/inactivity_detector.dart';

/// Diálogo para agregar cupones de descuento
class CouponDialog {
  static void show(BuildContext context, WidgetRef ref, Cart cart) {
    final d = ref.read(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final TextEditingController couponController = TextEditingController();
    bool isLoading = false;
    String? errorMessage;

    showDialog(
      context: context,
      barrierDismissible: !isLoading,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return InactivityDetector(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(d.borderRadiusL),
                ),
                child: Container(
                padding: EdgeInsets.all(d.spacingL),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(d.borderRadiusL),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header con ícono
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(d.spacingS),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(d.borderRadiusM),
                          ),
                          child: Icon(
                            Icons.local_offer,
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
                                'Agregar Cupón',
                                style: AppTextStyles.subtitle(d).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: d.spacingXS),
                              Text(
                                'Ingresa tu código de descuento',
                                style: AppTextStyles.caption(d).copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: d.spacingL),
                    
                    // Input mejorado
                    TextField(
                      controller: couponController,
                      decoration: InputDecoration(
                        labelText: 'Código del cupón',
                        hintText: 'Ej: 10SOLES, 20PCT',
                        prefixIcon: Icon(
                          Icons.confirmation_number,
                          color: colorScheme.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                          borderSide: BorderSide(color: colorScheme.outline),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                          borderSide: BorderSide(color: colorScheme.primary, width: d.borderWidth),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                          borderSide: BorderSide(color: colorScheme.error, width: d.borderWidth),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                          borderSide: BorderSide(color: colorScheme.error, width: d.borderWidth),
                        ),
                        errorText: errorMessage,
                        errorStyle: AppTextStyles.caption(d).copyWith(
                          color: colorScheme.error,
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                      ),
                      style: AppTextStyles.body(d),
                      textCapitalization: TextCapitalization.characters,
                      enabled: !isLoading,
                      autofocus: true,
                    ),
                    
                    if (isLoading) ...[
                      SizedBox(height: d.spacingL),
                      Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: colorScheme.primary,
                              strokeWidth: 3,
                            ),
                            SizedBox(height: d.spacingM),
                            Text(
                              'Validando cupón...',
                              style: AppTextStyles.caption(d).copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    SizedBox(height: d.spacingL),
                    
                    // Botones mejorados
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: isLoading ? null : () {
                              Navigator.of(dialogContext).pop();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: d.spacingM),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(d.borderRadiusM),
                              ),
                            ),
                            child: Text(
                              'Cancelar',
                              style: AppTextStyles.button(d).copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: d.spacingM),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () async {
                              await _handleCouponValidation(
                                context,
                                dialogContext,
                                ref,
                                cart,
                                couponController,
                                setState,
                                (loading) => isLoading = loading,
                                (error) => errorMessage = error,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              padding: EdgeInsets.symmetric(vertical: d.spacingM),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(d.borderRadiusM),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Aplicar Cupón',
                              style: AppTextStyles.button(d).copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> _handleCouponValidation(
    BuildContext context,
    BuildContext dialogContext,
    WidgetRef ref,
    Cart cart,
    TextEditingController couponController,
    StateSetter setState,
    Function(bool) setLoading,
    Function(String?) setError,
  ) async {
    final couponCode = couponController.text.trim();
    if (couponCode.isEmpty) {
      setState(() {
        setError('Ingresa un código de cupón');
      });
      return;
    }

    setState(() {
      setLoading(true);
      setError(null);
    });

    try {
      final couponService = ref.read(couponServiceProvider);
      final response = await couponService.validateCoupon(
        couponCode: couponCode,
        purchaseAmount: cart.totalPrice,
      );
      if (!context.mounted) return;
      if (response.valid) {
        ref.read(cartNotifierProvider.notifier).applyCoupon(response.coupon);
        Navigator.of(dialogContext).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Cupón aplicado exitosamente!'),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
      }
    } on CouponValidationException catch (e) {
      setState(() {
        setError(e.message);
        setLoading(false);
      });
    } catch (e) {
      setState(() {
        setError('Error de conexión. Intenta nuevamente.');
        setLoading(false);
      });
    }
  }
}
