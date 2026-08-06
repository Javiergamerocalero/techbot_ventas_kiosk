import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart/cart_provider.dart';
import '../providers/utils/timer_provider.dart';
import '../screens/time_up_screen.dart';
import '../widgets/utils/linear_timer.dart';
import '../widgets/utils/inactivity_detector.dart';
import '../styles/app_styles.dart';
import '../providers/config/app_dimensions_provider.dart';
import '../models/config/app_dimensions.dart';
import '../models/cart/cart_item.dart';
import '../models/cart/cart.dart';
import '../models/combos/combo_cart_item.dart';
import '../widgets/images/cached_product_image.dart';
import '../widgets/images/cached_combo_image.dart';
import '../widgets/payment/payment_method_card.dart';
import '../providers/config/payment_methods_provider.dart';
import '../models/config/payment_method.dart';
import 'invoice_selection_screen.dart';
import '../helpers/payment_navigation_helper.dart';
import '../models/config/invoice_type.dart';
import '../providers/config/invoice_settings_provider.dart';

class PaymentConfirmationScreen extends ConsumerStatefulWidget {
  static const routeName = '/payment-confirmation';
  const PaymentConfirmationScreen({super.key});

  @override
  ConsumerState<PaymentConfirmationScreen> createState() => _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends ConsumerState<PaymentConfirmationScreen> {
  PaymentMethod? _selectedPaymentMethod;
  bool _hasAutoSelected = false;

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final cart = ref.watch(cartNotifierProvider);
    final timer = ref.watch(timerProvider);
    final activePaymentMethods = ref.watch(activePaymentMethodsProvider);

    // Obtener símbolo de moneda del primer item (productos o combos)
    String currencySymbol = 'PEN'; // Fallback
    if (cart.items.isNotEmpty) {
      currencySymbol = cart.items.first.product.currencySymbol;
    } else if (cart.comboItems.isNotEmpty) {
      currencySymbol = cart.comboItems.first.combo.currencySymbol;
    }

    // Selección automática cuando solo hay un método de pago
    if (!_hasAutoSelected && activePaymentMethods.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _selectedPaymentMethod == null) {
          setState(() {
            _selectedPaymentMethod = activePaymentMethods.first;
            _hasAutoSelected = true;
          });
          print('💳 Método de pago seleccionado automáticamente: ${activePaymentMethods.first.type.displayName}');
        }
      });
    }

    handleTimer(context, ref, timer);

    return Scaffold(
      body: InactivityDetector(
        child: Stack(
          children: [
            Column(
              children: [
                _buildPaymentHeader(context, ref, d, colorScheme),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(d.horizontalPadding),
                          itemCount: cart.items.length + cart.comboItems.length,
                          separatorBuilder: (context, index) => SizedBox(height: d.spacingM),
                            itemBuilder: (context, index) {
                              if (index < cart.items.length) {
                                // Mostrar producto
                                final item = cart.items[index];
                                return Card(
                                  child: ListTile(
                                    leading: Container(
                                      width: d.imageSizeS,
                                      height: d.imageSizeS * 0.8, // Altura rectangular como en ProductsScreen
                                      decoration: BoxDecoration(
                                        color: Colors.white, // Fondo blanco para mejor contraste
                                        borderRadius: BorderRadius.circular(d.borderRadiusM),
                                      ),
                                      child: CachedProductImage(
                                        product: item.product,
                                        width: double.infinity,
                                        height: d.imageSizeS * 0.8,
                                        fit: BoxFit.contain,
                                        borderRadius: BorderRadius.circular(d.borderRadiusM),
                                      ),
                                    ),
                                    title: Text(item.product.name, style: AppTextStyles.body(d)),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (item.selectedVariation != null) ...[
                                          Text(
                                            item.selectedVariation!.formattedAttributes,
                                            style: AppTextStyles.caption(d).copyWith(
                                              color: colorScheme.onSurfaceVariant,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(height: d.spacingXS * 0.5),
                                        ],
                                        Text('$currencySymbol${item.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.price(d)),
                                      ],
                                    ),
                                    trailing: Container(
                                      width: d.iconSizeL * 1.5,
                                      height: d.iconSizeM * 1.2,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: d.spacingS,
                                        vertical: d.spacingXS,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.onSurface.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(d.borderRadiusS),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'x${item.quantity}',
                                          style: AppTextStyles.body(d).copyWith(
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: d.fontSizeCaption * 1.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                // Mostrar combo
                                final comboIndex = index - cart.items.length;
                                final comboItem = cart.comboItems[comboIndex];
                                return Card(
                                  child: ListTile(
                                    leading: Container(
                                      width: d.imageSizeS,
                                      height: d.imageSizeS * 0.8, // Altura rectangular como en ProductsScreen
                                      decoration: BoxDecoration(
                                        color: Colors.white, // Fondo blanco para mejor contraste
                                        borderRadius: BorderRadius.circular(d.borderRadiusM),
                                      ),
                                      child: CachedComboImage(
                                        combo: comboItem.combo,
                                        width: double.infinity,
                                        height: d.imageSizeS * 0.8,
                                        fit: BoxFit.contain,
                                        borderRadius: BorderRadius.circular(d.borderRadiusM),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(Icons.restaurant_menu, size: d.iconSizeS * 0.8, color: colorScheme.onPrimary),
                                        SizedBox(width: d.spacingXS),
                                        Expanded(
                                          child: Text(comboItem.combo.name, style: AppTextStyles.body(d)),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text('$currencySymbol${comboItem.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.price(d)),
                                    trailing: Container(
                                      width: d.iconSizeL * 1.5,
                                      height: d.iconSizeM * 1.2,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: d.spacingS,
                                        vertical: d.spacingXS,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.onSurface.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(d.borderRadiusS),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'x${comboItem.quantity}',
                                          style: AppTextStyles.body(d).copyWith(
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: d.fontSizeCaption * 1.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        // Resumen de precios dentro del padding
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
                          child: Column(
                            children: [
                              SizedBox(height: d.spacingL),
                              Divider(height: d.spacingL, color: colorScheme.onSurface.withValues(alpha: 0.1)),
            
            // Resumen de precios
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: AppTextStyles.body(d)),
                Text('$currencySymbol${cart.subtotal.toStringAsFixed(2)}', style: AppTextStyles.body(d)),
              ],
            ),
            
            // Descuentos de productos
            if (cart.productDiscounts > 0) ...[
              SizedBox(height: d.spacingS),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Descuentos', style: AppTextStyles.body(d)),
                  Text('-$currencySymbol${cart.productDiscounts.toStringAsFixed(2)}', 
                       style: AppTextStyles.body(d).copyWith(color: AppColors.error)),
                ],
              ),
            ],
            
            // Cupón aplicado
            if (cart.hasCoupon) ...[
              SizedBox(height: d.spacingS),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.local_offer, 
                             color: AppColors.success, 
                             size: d.iconSizeS),
                        SizedBox(width: d.spacingXS),
                        Expanded(
                          child: Text(
                            cart.appliedCoupon!.description,
                            style: AppTextStyles.body(d).copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '-$currencySymbol${cart.couponDiscount.toStringAsFixed(2)}',
                    style: AppTextStyles.body(d).copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: d.spacingM),
            Divider(height: d.spacingS, color: colorScheme.onSurface.withValues(alpha: 0.1)),
            SizedBox(height: d.spacingS),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: AppTextStyles.subtitle(d)),
                Text('$currencySymbol${cart.finalPrice.toStringAsFixed(2)}', style: AppTextStyles.price(d)),
              ],
            ),
            SizedBox(height: d.spacingM),
            
            // Sección de métodos de pago
            if (activePaymentMethods.isNotEmpty) ...[
              Text(
                'Método de pago',
                style: AppTextStyles.body(d).copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: d.spacingS),
              _buildPaymentMethodsGrid(d, colorScheme, activePaymentMethods),
              SizedBox(height: d.spacingM),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedPaymentMethod != null
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.3),
                  padding: EdgeInsets.symmetric(vertical: d.spacingM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(d.borderRadiusL),
                  ),
                ),
                onPressed: _selectedPaymentMethod != null
                    ? () async {
                        print('💳 Navegando con método de pago: ${_selectedPaymentMethod!.type.displayName}');
                        // Si la facturación electrónica está suspendida, se omite la
                        // selección de comprobante y se va directo al pago (solo imprime).
                        final suspendInvoice = ref.read(electronicInvoiceSuspendedProvider);
                        if (suspendInvoice) {
                          await PaymentNavigationHelper.navigateToPaymentScreen(
                            context: context,
                            paymentMethod: _selectedPaymentMethod!,
                            invoiceData: const InvoiceData(type: InvoiceType.simpleBoleta).toJson(),
                            amount: cart.computedTotalPrice,
                          );
                        } else {
                          Navigator.of(context).pushNamed(
                            InvoiceSelectionScreen.routeName,
                            arguments: _selectedPaymentMethod,
                          );
                        }
                      }
                    : () {
                        _showPaymentMethodRequiredDialog(context, d, colorScheme);
                      },
                child: Text(
                  _selectedPaymentMethod != null
                      ? 'Continuar'
                      : 'Selecciona un método de pago',
                  style: AppTextStyles.button(d).copyWith(
                    color: _selectedPaymentMethod != null
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            SizedBox(height: d.spacingXL),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            LinearTimer(timer: timer),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentHeader(BuildContext context, WidgetRef ref, dynamic d, ColorScheme colorScheme) {
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
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onSurface,
                size: d.iconSizeM,
              ),
            ),
          ),
          SizedBox(width: d.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen de Compra',
                  style: AppTextStyles.title(d).copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Revisa tu pedido antes de pagar',
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsGrid(
    AppDimensions d,
    ColorScheme colorScheme,
    List<PaymentMethod> methods,
  ) {
    return SizedBox(
      height: d.buttonHeight * 0.8, // Altura fija compacta
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: methods.length,
        separatorBuilder: (context, index) => SizedBox(width: d.spacingS),
        itemBuilder: (context, index) {
          final method = methods[index];
          return SizedBox(
            width: d.screenWidth * 0.4, // Ancho fijo para cada card
            child: PaymentMethodCard(
              paymentMethod: method,
              isSelected: _selectedPaymentMethod?.type == method.type,
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = method;
                });
                print('💳 Método de pago seleccionado: ${method.type.displayName}');
              },
              dimensions: d,
            ),
          );
        },
      ),
    );
  }

  void _showPaymentMethodRequiredDialog(
    BuildContext context,
    AppDimensions d,
    ColorScheme colorScheme,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(d.borderRadiusM),
        ),
        title: Row(
          children: [
            Icon(
              Icons.payment,
              color: colorScheme.primary,
              size: d.iconSizeL,
            ),
            SizedBox(width: d.spacingM),
            Expanded(
              child: Text(
                'Método de pago requerido',
                style: AppTextStyles.subtitle(d),
              ),
            ),
          ],
        ),
        content: Text(
          'Por favor, selecciona un método de pago antes de continuar.',
          style: AppTextStyles.body(d),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Entendido',
              style: AppTextStyles.body(d).copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleTimer(BuildContext context, WidgetRef ref, int timer) async {
    if (timer == 0) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(timerProvider.notifier).start(ref.read(secondaryDurationProvider));
          Navigator.pushNamed(context, TimeUpScreen.routeName);
        });
      }
    }
  }
}
