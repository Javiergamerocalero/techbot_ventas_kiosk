import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/utils/inactivity_detector.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/orders/order_provider.dart';
import 'package:ventas_kiosko/services/order_service.dart';
import 'package:ventas_kiosko/services/niubiz_service.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/screens/payment_success_screen.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/models/config/invoice_type.dart';
import 'package:ventas_kiosko/models/config/payment_method.dart';
import 'package:ventas_kiosko/providers/invoice/electronic_invoice_provider.dart';
import 'package:ventas_kiosko/providers/invoice/internal_invoice_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/widgets/ticket/ticket_preview_modal.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';
import 'package:ventas_kiosko/services/ticket_service.dart';
import 'package:ventas_kiosko/providers/config/invoice_settings_provider.dart';

enum PaymentState {
  idle, // Initial state
  processingPayment, // Calling PinPad
  paymentApproved, // Payment successful
  creatingOrder, // Backend order creation
  generatingInvoice, // Electronic invoice generation
  printingTicket, // Printing receipt
  completed, // Success
  error, // Payment failed
}

class PaymentStandbyScreen extends ConsumerStatefulWidget {
  static const routeName = '/payment-standby';
  const PaymentStandbyScreen({super.key});

  @override
  ConsumerState<PaymentStandbyScreen> createState() => _PaymentStandbyScreenState();
}

class _PaymentStandbyScreenState extends ConsumerState<PaymentStandbyScreen> {
  PaymentState _paymentState = PaymentState.idle;
  bool _useTestMode = false;

  @override
  void initState() {
    super.initState();
    _loadTestMode();
  }

  void _loadTestMode() {
    final useMock = dotenv.get('USE_MOCK_PAYMENT', fallback: 'false');
    setState(() {
      _useTestMode = useMock.toLowerCase() == 'true';
    });
    if (_useTestMode) {
      print('🧪 Test mode enabled from .env');
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final cartState = ref.watch(cartNotifierProvider);
    
    // Obtener símbolo de moneda del primer item (productos o combos)
    String currencySymbol = 'PEN'; // Fallback
    if (cartState.items.isNotEmpty) {
      currencySymbol = cartState.items.first.product.currencySymbol;
    } else if (cartState.comboItems.isNotEmpty) {
      currencySymbol = cartState.comboItems.first.combo.currencySymbol;
    }

    return Scaffold(
      floatingActionButton: _buildTestTicketButton(ref, cartState),
      body: InactivityDetector(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(context, ref, d, colorScheme),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(d.horizontalPadding, d.spacingXL, d.horizontalPadding, d.spacingXL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tarjeta de instrucciones y monto
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(d.spacingL),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(d.borderRadiusL),
                            border: Border.all(color: colorScheme.outline.withValues(alpha: 0.15)),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.onSurface.withValues(alpha: 0.06),
                                blurRadius: d.blurRadius,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: d.iconSizeL,
                                    height: d.iconSizeL,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.credit_card, color: colorScheme.primary, size: d.iconSizeM),
                                  ),
                                  SizedBox(width: d.spacingM),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Acerque el método de pago',
                                          style: AppTextStyles.subtitle(d).copyWith(color: colorScheme.onSurface),
                                        ),
                                        Text(
                                          'Siga las instrucciones en el terminal',
                                          style: AppTextStyles.caption(
                                            d,
                                          ).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: d.spacingL),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total a cobrar',
                                    style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface),
                                  ),
                                  Text('$currencySymbol${cartState.finalPrice.toStringAsFixed(2)}', style: AppTextStyles.price(d)),
                                ],
                              ),
                              SizedBox(height: d.spacingL),
                              // Pasos cortos
                              _StandbyStep(
                                icon: Icons.nfc,
                                text: 'Acerque tarjeta o presente el QR al terminal',
                                d: d,
                                colorScheme: colorScheme,
                              ),
                              SizedBox(height: d.spacingS),
                              _StandbyStep(
                                icon: Icons.password,
                                text: 'Si se solicita, ingrese el PIN o firme en el terminal',
                                d: d,
                                colorScheme: colorScheme,
                              ),
                              SizedBox(height: d.spacingS),
                              _StandbyStep(
                                icon: Icons.check_circle_outline,
                                text: 'Espere la confirmación en el terminal',
                                d: d,
                                colorScheme: colorScheme,
                              ),
                              SizedBox(height: d.spacingXL),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    padding: EdgeInsets.symmetric(vertical: d.spacingM),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusL)),
                                  ),
                                  onPressed: () async {
                                    final cart = ref.read(cartNotifierProvider);

                                    // Extraer datos de facturación y método de pago
                                    final arguments =
                                        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

                                    // invoiceData viene como Map<String, dynamic> desde PaymentNavigationHelper
                                    final invoiceDataMap = arguments?['invoiceData'] as Map<String, dynamic>?;
                                    final invoiceData = invoiceDataMap != null
                                        ? InvoiceData.fromJson(invoiceDataMap)
                                        : null;

                                    // paymentMethod viene como objeto PaymentMethod desde PaymentNavigationHelper
                                    final paymentMethod = arguments?['paymentMethod'] as PaymentMethod?;

                                    if (paymentMethod == null) {
                                      print('❌ ERROR: No se recibió método de pago');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Error: Método de pago no seleccionado'),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                      return;
                                    }

                                    print('💳 Procesando con método de pago: ${paymentMethod.type.displayName}');

                                    // Show processing dialog
                                    if (!mounted) return;
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => _buildProcessingDialog(),
                                    );

                                    try {
                                      // ==========================================
                                      // STEP 1: PAYMENT PROCESSING
                                      // ==========================================
                                      setState(() => _paymentState = PaymentState.processingPayment);

                                      print('💳 INICIANDO PAGO');
                                      print('💰 Monto: S/${cart.finalPrice}');
                                      print('💳 Método: ${paymentMethod.type.displayName}');

                                      // Verificar que sea Niubiz Lane3000 (único método implementado actualmente)
                                      if (paymentMethod.type != PaymentMethodType.niubizLane3000) {
                                        // - Niubiz IM30 (requiere implementación diferente)
                                        // - Izipay
                                        // - CashDro S
                                        print(
                                          '⚠️ Método de pago ${paymentMethod.type.displayName} aún no implementado',
                                        );
                                        if (!mounted) return;
                                        Navigator.of(context).pop();
                                        _showPaymentError(
                                          context,
                                          'El método de pago ${paymentMethod.type.displayName} aún no está implementado.\n\nActualmente solo Niubiz/Lane3000 está disponible.',
                                        );
                                        return;
                                      }

                                      // Procesar pago con Niubiz Lane3000
                                      final niubizService = NiubizService();
                                      dynamic paymentResponse;

                                      if (_useTestMode) {
                                        final mockType = dotenv.get('MOCK_PAYMENT_TYPE', fallback: 'Success');
                                        print('🧪 Modo de prueba activado (tipo: $mockType)');
                                        paymentResponse = await niubizService.mockPaymentProcess(
                                          cart.finalPrice,
                                          mockType,
                                        );
                                      } else {
                                        paymentResponse = await niubizService.paymentProcess(cart.finalPrice);
                                      }

                                      // Check if payment failed
                                      if (paymentResponse is Exception) {
                                        print('❌ ERROR EN PAGO');
                                        final errorMsg = paymentResponse.toString().replaceAll('Exception: ', '');
                                        print('📝 Error: $errorMsg');

                                        if (!context.mounted) return;
                                        Navigator.of(context).pop(); // Close dialog
                                        _showPaymentError(context, errorMsg);
                                        return; // Stay on screen, allow retry
                                      }

                                      // Payment successful - extract data
                                      print('✅ PAGO EXITOSO');
                                      final transactionId = paymentResponse['transactionId'] as String?;
                                      final authNumber = paymentResponse['authNumber'] as String?;
                                      final maskedPAN = paymentResponse['maskedPAN'] as String?;
                                      final cardType = paymentResponse['cardType'] as String?;
                                      final cardBrand = paymentResponse['transactionBrand'] as String?;
                                      final paymentDate = paymentResponse['date'] as String?;
                                      final paymentTime = paymentResponse['time'] as String?;
                                      final voucherNumber = paymentResponse['voucherNumber'] as String?;
                                      final batchNumber = paymentResponse['batchNumber'] as String?;
                                      final voucherClient = paymentResponse['voucherClient'] as String?;
                                      final voucherMerchant = paymentResponse['voucherMerchant'] as String?;

                                      print('🔢 Transaction ID: $transactionId');
                                      print('🏦 Auth Number: $authNumber');
                                      print('💳 Card: $maskedPAN ($cardType - $cardBrand)');

                                      // Validate essential fields
                                      if (transactionId == null || authNumber == null || maskedPAN == null) {
                                        print('❌ ERROR: Datos de pago incompletos');
                                        if (!context.mounted) return;
                                        Navigator.of(context).pop();
                                        _showPaymentError(context, 'Error: Datos de pago incompletos');
                                        return;
                                      }

                                      // Brief pause to show "Payment approved"
                                      setState(() => _paymentState = PaymentState.paymentApproved);
                                      await Future.delayed(const Duration(milliseconds: 800));

                                      // ==========================================
                                      // STEP 2: ORDER CREATION
                                      // ==========================================
                                      setState(() => _paymentState = PaymentState.creatingOrder);

                                      print('\n📦 CREANDO ORDEN');

                                      // Prepare payment data for backend and ticket
                                      final paymentData = <String, dynamic>{
                                        'transaction_id': transactionId,
                                        'auth_number': authNumber,
                                        'masked_pan': maskedPAN,
                                        'card_type': cardType,
                                        'card_brand': cardBrand,
                                        'payment_date': paymentDate,
                                        'payment_time': paymentTime,
                                        'voucher_number': voucherNumber,
                                        'batch_number': batchNumber,
                                        'voucher_client': voucherClient,
                                        'voucher_merchant': voucherMerchant,
                                        // Datos del cliente para el ticket
                                        'clientDocType': invoiceData?.type == InvoiceType.facturaElectronica ? 'RUC' : 'DNI',
                                        'clientDocNumber': invoiceData?.type == InvoiceType.facturaElectronica 
                                            ? invoiceData?.ruc ?? '' 
                                            : invoiceData?.dni ?? '',
                                        'clientName': invoiceData?.type == InvoiceType.facturaElectronica 
                                            ? invoiceData?.razonSocial ?? 'Cliente General' 
                                            : invoiceData?.dniFullName ?? 'Cliente General',
                                      };

                                      final orderResponse = await ref.read(
                                        processOrderProvider(
                                          cart.finalPrice,
                                          cart.appliedCoupon?.code,
                                          paymentData,
                                        ).future,
                                      );

                                      print('✅ Orden creada: ${orderResponse.orderId}');

                                      // ==========================================
                                      // STEP 3: INVOICE GENERATION (if requested)
                                      // ==========================================
                                      // Si la facturación electrónica está suspendida en configuración,
                                      // se omite el correlativo y el envío a TechFact: solo se imprime.
                                      final suspendInvoice = ref.read(electronicInvoiceSuspendedProvider);
                                      if (!suspendInvoice && invoiceData != null && orderResponse.orderId != null) {
                                        setState(() => _paymentState = PaymentState.generatingInvoice);
                                        print('\n🧾 INICIANDO FACTURACIÓN ELECTRÓNICA');

                                        int? reservedInvoiceId;
                                        String? formattedNumber;
                                        int? invoiceNumber;
                                        String? seriePrefix;
                                        bool hasCorrelativo = true;

                                        try {
                                          // PASO 1: Reservar correlativo interno
                                          print('📝 PASO 1: Reservando correlativo...');

                                          final documentType = invoiceData.type == InvoiceType.facturaElectronica
                                              ? 'factura'
                                              : 'boleta';

                                          try {
                                            final reserveResponse = await ref
                                                .read(internalInvoiceProvider.notifier)
                                                .reserveNumber(
                                                  orderId: orderResponse.orderId!,
                                                  documentType: documentType,
                                                );

                                            final data = reserveResponse['data'] as Map<String, dynamic>;

                                            reservedInvoiceId = data['invoice_id'] as int;
                                            invoiceNumber = data['invoice_number'] as int;
                                            formattedNumber = data['formatted_number'] as String;
                                            seriePrefix = data['series_prefix'] as String?;

                                            print('✅ Correlativo reservado: $formattedNumber (ID: $reservedInvoiceId)');

                                            // Fallback para serie si no viene del backend
                                            if (seriePrefix == null || seriePrefix.isEmpty) {
                                              seriePrefix = documentType == 'factura' ? 'F001' : 'B001';
                                              print('⚠️ Usando serie por defecto: $seriePrefix');
                                            }
                                          } catch (e) {
                                            print('❌ Error al reservar correlativo: $e');
                                            hasCorrelativo = false;
                                          }

                                          // Solo continuar con facturación si hay correlativo
                                          if (hasCorrelativo) {
                                            // PASO 2: Generar y enviar al API externo
                                            print('📤 PASO 2: Enviando a API externa...');
                                            final externalResponse = await ref
                                                .read(electronicInvoiceProvider.notifier)
                                                .generateAndSendInvoice(
                                                  cart: cart,
                                                  invoiceData: invoiceData,
                                                  numeroCorrelativo: invoiceNumber!,
                                                  serie: seriePrefix!,
                                                  orderId: orderResponse.orderId?.toString(),
                                                  paymentMethodName: paymentMethod.type.displayName,
                                                );

                                            final hasInvoice = externalResponse.enlace.isNotEmpty;

                                            if (hasInvoice) {
                                              print('✅ Comprobante generado: ${externalResponse.numeroCompleto}');

                                              // PASO 3: Finalizar factura interna
                                              print('✅ PASO 3: Finalizando factura...');
                                              await ref
                                                  .read(internalInvoiceProvider.notifier)
                                                  .finalize(
                                                    invoiceId: reservedInvoiceId!,
                                                    invoiceData: externalResponse.toJson(),
                                                  );

                                              print('🎉 Facturación completada');
                                            } else {
                                              print('⚠️ Error en API externa: ${externalResponse.errorMessage}');

                                              // Cancelar la reserva
                                              if (reservedInvoiceId != null) {
                                                await ref
                                                    .read(internalInvoiceProvider.notifier)
                                                    .cancel(
                                                      invoiceId: reservedInvoiceId,
                                                      reason:
                                                          'Error al generar comprobante: ${externalResponse.errorMessage}',
                                                    );
                                              }
                                            }
                                          } else {
                                            print('⚠️ Sin correlativos disponibles para $documentType');
                                          }
                                        } catch (e) {
                                          print('❌ Error en facturación: $e');

                                          // Rollback si hay factura reservada
                                          if (reservedInvoiceId != null) {
                                            try {
                                              await ref
                                                  .read(internalInvoiceProvider.notifier)
                                                  .cancel(invoiceId: reservedInvoiceId, reason: 'Error en proceso: $e');
                                            } catch (_) {
                                              // Ignorar errores de rollback
                                            }
                                          }
                                        }
                                      }

                                      // ==========================================
                                      // STEP 4: PRINT TICKET (ANTES de limpiar cart)
                                      // ==========================================
                                      setState(() => _paymentState = PaymentState.printingTicket);
                                      print('\n🎫 IMPRIMIENDO TICKET');

                                      // Obtener deviceName del licenseProvider
                                      final licenseData = await ref.read(licenseProvider.future);
                                      final deviceName = licenseData.deviceName;

                                      // Imprimir ticket con el cart ANTES de limpiarlo
                                      try {
                                        await _printTicket(
                                          cart: cart,
                                          paymentData: paymentData,
                                          deviceName: deviceName,
                                        );
                                        print('✅ TICKET IMPRESO EXITOSAMENTE');
                                      } catch (e) {
                                        print('⚠️ Error en impresión (no crítico): $e');
                                        // Show warning to user but continue with the flow
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Advertencia: No se pudo imprimir el ticket. ${e.toString().replaceAll('Exception: ', '')}'),
                                              backgroundColor: Colors.orange,
                                              duration: const Duration(seconds: 5),
                                            ),
                                          );
                                        }
                                      }

                                      // ==========================================
                                      // STEP 5: SUCCESS
                                      // ==========================================
                                      setState(() => _paymentState = PaymentState.completed);
                                      print('🎉 PROCESO COMPLETADO\n');

                                      if (!context.mounted) return;
                                      Navigator.of(context).pop(); // Close dialog
                                      ref.read(cartNotifierProvider.notifier).clearCart(); // Limpiar DESPUÉS de imprimir
                                      Navigator.of(context).pushReplacementNamed(PaymentSuccessScreen.routeName);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(orderResponse.message),
                                          backgroundColor: colorScheme.primary,
                                        ),
                                      );
                                    } on OrderProcessingException catch (e) {
                                      print('❌ ERROR AL CREAR ORDEN: ${e.message}');
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                      _showPaymentError(context, e.message);
                                    } catch (e) {
                                      print('❌ ERROR INESPERADO: $e');
                                      if (!mounted) return;
                                      Navigator.of(context).pop();
                                      _showPaymentError(context, 'Error inesperado: ${e.toString()}');
                                    }
                                  },
                                  child: Text('Procesar pago', style: AppTextStyles.button(d)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: d.spacingL),
                        // Nota de ayuda
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(d.spacingM),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(d.borderRadiusM),
                            border: Border.all(color: colorScheme.outline.withValues(alpha: 0.15)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline, size: d.iconSizeS, color: colorScheme.primary),
                              SizedBox(width: d.spacingS),
                              Expanded(
                                child: Text(
                                  'Si el terminal no responde después de unos segundos, toque “Finalizar pago (provisional)” para completar la orden.',
                                  style: AppTextStyles.caption(
                                    d,
                                  ).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.9)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, dynamic d, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.only(
        top: d.screenHeight * 0.015 + d.spacingM,
        left: d.horizontalPadding,
        right: d.horizontalPadding,
        bottom: d.spacingM,
      ),
      child: Row(
        children: [
          Container(
            width: d.buttonHeight,
            height: d.buttonHeight,
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  blurRadius: d.blurRadius,
                  offset: Offset(0, d.spacingXS),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, color: colorScheme.onSurface, size: d.iconSizeM),
            ),
          ),
          SizedBox(width: d.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pago en proceso', style: AppTextStyles.title(d).copyWith(color: colorScheme.onSurface)),
                Text(
                  'Conectando con el terminal de pago...',
                  style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingDialog() {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    String message;
    IconData? icon;
    Color? iconColor;

    switch (_paymentState) {
      case PaymentState.processingPayment:
        message = 'Procesando pago con tarjeta...';
        icon = Icons.credit_card;
        iconColor = colorScheme.primary;
        break;
      case PaymentState.paymentApproved:
        message = 'Pago aprobado ✓';
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case PaymentState.creatingOrder:
        message = 'Creando orden...';
        icon = Icons.receipt_long;
        iconColor = colorScheme.primary;
        break;
      case PaymentState.generatingInvoice:
        message = 'Generando comprobante electrónico...';
        icon = Icons.description;
        iconColor = colorScheme.primary;
        break;
      case PaymentState.printingTicket:
        message = 'Imprimiendo ticket...';
        icon = Icons.print;
        iconColor = colorScheme.primary;
        break;
      case PaymentState.completed:
        message = 'Completado ✓';
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;
      default:
        message = 'Procesando...';
        icon = Icons.hourglass_empty;
        iconColor = colorScheme.primary;
    }

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_paymentState == PaymentState.paymentApproved || _paymentState == PaymentState.completed)
            Icon(icon, color: iconColor, size: d.iconSizeM)
          else
            SizedBox(
              width: d.iconSizeM,
              height: d.iconSizeM,
              child: CircularProgressIndicator(color: colorScheme.primary, strokeWidth: d.borderWidth * 3),
            ),
          SizedBox(width: d.spacingM),
          Flexible(
            child: Text(message, style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface)),
          ),
        ],
      ),
    );
  }

  void _showPaymentError(BuildContext context, String errorMessage) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: d.iconSizeL),
            SizedBox(width: d.spacingS),
            Text('Error en el pago', style: AppTextStyles.subtitle(d).copyWith(color: colorScheme.onSurface)),
          ],
        ),
        content: Text(errorMessage, style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close error dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: Text(
              'Cancelar',
              style: AppTextStyles.button(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close error dialog
              // User stays on payment screen to retry
            },
            child: Text('Reintentar', style: AppTextStyles.button(d).copyWith(color: colorScheme.onPrimary)),
          ),
        ],
      ),
    );
  }

  /// Imprime el ticket de venta automáticamente después del pago exitoso
  Future<void> _printTicket({
    required Cart cart,
    required Map<String, dynamic> paymentData,
    required String deviceName,
  }) async {
    try {
      print('🎫 INICIANDO IMPRESIÓN DE TICKET');
      print('   Cart items: ${cart.items.length} productos, ${cart.comboItems.length} combos');
      print('   Device: $deviceName');
      
      // Obtener BusinessInfo de la licencia
      final businessInfo = ref.read(licenseProvider.notifier).currentBusinessInfo;
      print('🏢 BusinessInfo: ${businessInfo != null ? "${businessInfo.businessName} - ${businessInfo.taxId}" : "NO DISPONIBLE (usando datos demo)"}');
      
      // Si la facturación electrónica está suspendida, el ticket se imprime
      // como comprobante no fiscal (sin serie/correlativo).
      final fiscal = !ref.read(electronicInvoiceSuspendedProvider);

      // Generar el string del ticket usando TicketService con BusinessInfo
      final ticketString = TicketService.generateTicketString(
        cart: cart,
        paymentData: paymentData,
        deviceName: deviceName,
        businessInfo: businessInfo,
        fiscal: fiscal,
      );
      
      print('📄 Ticket generado (${ticketString.length} caracteres)');
      print('🖨️ Enviando a impresora...');
      
      // Imprimir usando el printer provider
      await ref.read(printerManagerProvider.notifier).print(
        ticketString,
        partialCut: true,
      );
      
      print('✅ TICKET IMPRESO EXITOSAMENTE');
    } catch (e) {
      print('❌ ERROR AL IMPRIMIR TICKET: $e');
    }
  }

  Widget? _buildTestTicketButton(WidgetRef ref, Cart cart) {
    final licenseData = ref.watch(licenseProvider);
    
    return licenseData.when(
      data: (license) {
        return FloatingActionButton.extended(
          onPressed: () {
            // Obtener invoiceData de los arguments
            final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
            final invoiceDataMap = arguments?['invoiceData'] as Map<String, dynamic>?;
            final invoiceData = invoiceDataMap != null ? InvoiceData.fromJson(invoiceDataMap) : null;
            
            // Datos de pago de prueba con datos del cliente dinámicos
            final testPaymentData = {
              'cardBrand': 'Visa',
              'maskedPAN': '****1234',
              'authNumber': '123456',
              'transactionId': 'TXN789012',
              'clientDocType': invoiceData?.type == InvoiceType.facturaElectronica ? 'RUC' : 'DNI',
              'clientDocNumber': invoiceData?.type == InvoiceType.facturaElectronica 
                  ? invoiceData?.ruc ?? '' 
                  : invoiceData?.dni ?? '',
              'clientName': invoiceData?.type == InvoiceType.facturaElectronica 
                  ? invoiceData?.razonSocial ?? '' 
                  : invoiceData?.dniFullName ?? '',
            };

            TicketPreviewModal.show(
              context: context,
              cart: cart,
              paymentData: testPaymentData,
              deviceName: license.deviceName,
            );
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          icon: const Icon(Icons.receipt_long),
          label: const Text('Test Ticket'),
        );
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }
}

class _StandbyStep extends StatelessWidget {
  final IconData icon;
  final String text;
  final AppDimensions d;
  final ColorScheme colorScheme;

  const _StandbyStep({required this.icon, required this.text, required this.d, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: d.iconSizeS, color: colorScheme.onSurface.withValues(alpha: 0.8)),
        SizedBox(width: d.spacingS),
        Expanded(
          child: Text(text, style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.9))),
        ),
      ],
    );
  }
}
