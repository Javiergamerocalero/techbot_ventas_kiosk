import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/services/ticket_service.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';

/// Modal para previsualizar el formato del ticket generado
class TicketPreviewModal extends ConsumerWidget {
  final Cart cart;
  final Map<String, dynamic> paymentData;
  final String deviceName;
  final int width;

  const TicketPreviewModal({
    super.key,
    required this.cart,
    required this.paymentData,
    required this.deviceName,
    this.width = 46,
  });

  /// Muestra el modal de preview del ticket
  static void show({
    required BuildContext context,
    required Cart cart,
    required Map<String, dynamic> paymentData,
    required String deviceName,
    int width = 46,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
          TicketPreviewModal(cart: cart, paymentData: paymentData, deviceName: deviceName, width: width),
    );
  }

  /// Crea datos de prueba para testing cuando no hay carrito real
  static void showWithTestData({required BuildContext context, required String deviceName, int width = 46}) {
    // Datos de pago de prueba
    final testPaymentData = {
      'cardBrand': 'Visa',
      'maskedPAN': '****1234',
      'authNumber': '123456',
      'transactionId': 'TXN789012',
    };

    // Carrito de prueba (vacío por ahora, se puede mejorar después)
    final testCart = const Cart();

    show(context: context, cart: testCart, paymentData: testPaymentData, deviceName: deviceName, width: width);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    // Obtener BusinessInfo de la licencia
    final businessInfo = ref.read(licenseProvider.notifier).currentBusinessInfo;
    print('🎫 Preview - BusinessInfo: ${businessInfo != null ? "${businessInfo.businessName} - ${businessInfo.taxId}" : "NO DISPONIBLE (usando datos demo)"}');
    
    // Debug completo del BusinessInfo
    ref.read(licenseProvider.notifier).debugBusinessInfo();

    // Generar el string del ticket con BusinessInfo
    final ticketString = TicketService.generateTicketString(
      cart: cart,
      paymentData: paymentData,
      deviceName: deviceName,
      businessInfo: businessInfo,
      width: width,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(d.spacingM),
      child: Container(
        width: double.infinity,
        height: d.screenHeight * 0.8,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(d.borderRadiusL),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
              blurRadius: d.blurRadius * 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header del modal
            Container(
              padding: EdgeInsets.all(d.spacingL),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(d.borderRadiusL),
                  topRight: Radius.circular(d.borderRadiusL),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.receipt_long, color: colorScheme.primary, size: d.iconSizeM),
                  SizedBox(width: d.spacingS),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preview del Ticket',
                          style: AppTextStyles.subtitle(
                            d,
                          ).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Ancho: $width caracteres',
                          style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: colorScheme.onSurface.withValues(alpha: 0.7), size: d.iconSizeM),
                  ),
                ],
              ),
            ),

            // Contenido del ticket
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(d.spacingM),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(d.borderRadiusM),
                    border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(d.spacingM),
                    child: Text(
                      ticketString,
                      style: TextStyle(
                        fontFamily: 'Courier', // Fuente monoespaciada
                        fontSize: d.fontSizeCaption * 0.9,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Footer con botones
            Container(
              padding: EdgeInsets.all(d.spacingL),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(d.borderRadiusL),
                  bottomRight: Radius.circular(d.borderRadiusL),
                ),
                border: Border(top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2))),
              ),
              child: Row(
                children: [
                  // Información del carrito
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items: ${cart.totalItems}',
                          style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                        ),
                        Text(
                          'Total: ${cart.finalPrice.toStringAsFixed(2)}',
                          style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  ),

                  // Botón de imprimir
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
                      padding: EdgeInsets.all(d.spacingM),
                    ),
                    onPressed: () async {
                      try {
                        await ref.read(printerManagerProvider.notifier).print(ticketString, partialCut: true);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Ticket impreso exitosamente'),
                              backgroundColor: colorScheme.primary,
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al imprimir: ${e.toString().replaceAll('Exception: ', '')}'),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                      }
                    },
                    child: Icon(Icons.print, color: colorScheme.onPrimary, size: d.iconSizeM),
                  ),

                  SizedBox(width: d.spacingM),

                  // Botón de cerrar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
                      padding: EdgeInsets.symmetric(horizontal: d.spacingL, vertical: d.spacingM),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cerrar', style: AppTextStyles.button(d).copyWith(color: colorScheme.onPrimary)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de botón flotante para testing del ticket
class TicketTestButton extends ConsumerWidget {
  final String deviceName;

  const TicketTestButton({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton.extended(
      onPressed: () {
        TicketPreviewModal.showWithTestData(context: context, deviceName: deviceName);
      },
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
      icon: const Icon(Icons.receipt_long),
      label: const Text('Test Ticket'),
    );
  }
}
