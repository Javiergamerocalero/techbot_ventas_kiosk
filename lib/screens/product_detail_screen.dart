import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/products/product.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/providers/products/variation_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import '../widgets/products/product_counter.dart';
import '../widgets/products/variation_selector.dart';
import '../screens/time_up_screen.dart';
import '../widgets/utils/linear_timer.dart';
import '../widgets/utils/inactivity_detector.dart';
import '../providers/utils/button_loading_provider.dart';
import '../widgets/images/product_image_carousel.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/providers/ui/stock_warning_provider.dart';
import '../screens/cart_screen.dart';
import 'package:ventas_kiosko/widgets/barcode/pre_payment_barcode_scope.dart';

class ProductDetailScreen extends ConsumerWidget {
  static const routeName = '/product-detail';
  final Product product;
  
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  /// Maneja el incremento de cantidad con validación de endpoint
  Future<void> _handleIncrement(BuildContext context, WidgetRef ref, int currentQuantity) async {
    // Verificar si requiere selección de variación
    if (product.hasVariations) {
      final selectedVariation = ref.read(selectedProductVariationProvider(product.id, product));
      if (selectedVariation == null) {
        // Mostrar mensaje pidiendo seleccionar variación
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Por favor selecciona una variación'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return;
      }
    }
    
    // Verificar stock local actualizado
    final localStock = ref.read(currentProductStockProvider(product.id));
    if (localStock <= currentQuantity) {
      final warning = ref.read(stockWarningProvider.notifier);
      final key = 'product_${product.id}';
      if (!warning.hasShownWarning(key)) {
        // Modal amigable
        await StockValidationModal.showOutOfStock(
          context: context,
          productName: product.name,
        );
        warning.markWarningShown(key);
      }
      return;
    }
    
    final buttonKey = 'product_${product.id}_increment';
    
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
        final newTotalQuantity = currentQuantity + 1;
        
        if (currentQuantity == 0) {
          // Obtener variación seleccionada si existe
          final selectedVariation = product.hasVariations 
              ? ref.read(selectedProductVariationProvider(product.id, product))
              : null;
          
          // Validar y agregar
          final resp = await ref.read(cartNotifierProvider.notifier).validateAndAddProduct(
            product, 
            quantity: 1,
            selectedVariation: selectedVariation,
          );
          if (!resp.isAvailable) {
            final warning = ref.read(stockWarningProvider.notifier);
            final key = 'product_${product.id}';
            if (!warning.hasShownWarning(key)) {
              if (!context.mounted) return;
              await StockValidationModal.showOutOfStock(
                context: context,
                productName: product.name,
              );
              warning.markWarningShown(key);
            }
          }
        } else {
          // Obtener variación seleccionada si el producto ya está en carrito
          final cartItem = ref.read(productInCartProvider(product.id.toString()));
          final variationId = cartItem?.selectedVariation?.id;
          
          print('🔍 ProductDetailScreen: Validando stock - Producto: ${product.name}, Cantidad: $newTotalQuantity, Variación: ${variationId ?? "ninguna"}');
          
          // Validar nueva cantidad total
          final response = await ref.read(cartNotifierProvider.notifier).validateStockOnly(
            product, 
            newTotalQuantity,
            variationId: variationId,
          );
          
          if (response.isAvailable) {
            ref.read(cartNotifierProvider.notifier).updateQuantity(product.id.toString(), newTotalQuantity);
          } else {
            final warning = ref.read(stockWarningProvider.notifier);
            final key = 'product_${product.id}';
            if (!warning.hasShownWarning(key)) {
              if (!context.mounted) return;
              await StockValidationModal.showOutOfStock(
                context: context,
                productName: product.name,
              );
              warning.markWarningShown(key);
            }
          }
        }
      });
    } catch (e) {
      // Si la operación ya está en progreso, ignorar silenciosamente
      if (e.toString().contains('Operation already in progress')) {
        return;
      }
      
      // Error de conexión: no mostrar modal, solo ignorar silenciosamente
    }
  }
  
  /// Maneja el decremento de cantidad
  Future<void> _handleDecrement(WidgetRef ref, int currentQuantity) async {
    final buttonKey = 'product_${product.id}_decrement';
    
    if (currentQuantity <= 0) return;
    
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
        final newQuantity = currentQuantity - 1;

        if (currentQuantity == 1) {
          // Remover producto completamente
          ref.read(cartNotifierProvider.notifier).removeProduct(product.id.toString());
        } else {
          // Decrementar cantidad localmente
          ref.read(cartNotifierProvider.notifier).updateQuantity(product.id.toString(), newQuantity);
        }

        // Optimismo: aumentar stock local +1 para habilitar "+" y reflejar disponibilidad
        final localStock = ref.read(currentProductStockProvider(product.id));
        final stockMap = ref.read(productStockMapProvider);
        ref.read(productStockMapProvider.notifier).state = {
          ...stockMap,
          product.id: localStock + 1,
        };

        // Sincronizar con backend (ignorar errores) y ajustar stock si viene en additionalData
        try {
          // Obtener variación seleccionada si el producto está en carrito
          final cartItem = ref.read(productInCartProvider(product.id.toString()));
          final variationId = cartItem?.selectedVariation?.id;
          
          final resp = await ref.read(cartNotifierProvider.notifier).validateStockOnly(
            product, 
            newQuantity,
            variationId: variationId,
          );
          
          if (resp.isAvailable && resp.additionalData != null) {
            final stockAvailable = resp.additionalData!['stock_available'] as int?;
            if (stockAvailable != null) {
              final currentMap = ref.read(productStockMapProvider);
              ref.read(productStockMapProvider.notifier).state = {
                ...currentMap,
                product.id: stockAvailable,
              };
            }
          }
        } catch (_) {}
      });
    } catch (e) {
      // Si la operación ya está en progreso, ignorar silenciosamente
      if (e.toString().contains('Operation already in progress')) {
        return;
      }
      
      print('Error decrementando producto: $e');
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final timer = ref.watch(timerProvider);
    final cartItem = ref.watch(productInCartProvider(product.id.toString()));
    final quantity = cartItem?.quantity ?? 0;
    
    // CRÍTICO: Usar stock actualizado para validación
    final currentStock = ref.watch(currentProductStockProvider(product.id));
    final isOutOfStock = ref.watch(isProductOutOfStockProvider(product.id));

    // Loader global de pantalla (increment/decrement)
    final isIncLoading = ref.watch(buttonIsLoadingProvider('product_${product.id}_increment'));
    final isDecLoading = ref.watch(buttonIsLoadingProvider('product_${product.id}_decrement'));
    final isScreenLoading = isIncLoading || isDecLoading;
    // Altura exacta del LinearTimer (1% de alto de pantalla)
    final timerHeight = MediaQuery.sizeOf(context).height * 0.01;

    handleTimer(context, ref, timer);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  // Carrusel de imágenes con espacio exacto del timer
                  Padding(
                    padding: EdgeInsets.only(top: timerHeight),
                    child: ProductImageCarousel(
                      product: product,
                      height: d.screenHeight * 0.35,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(d.borderRadiusL),
                        bottomRight: Radius.circular(d.borderRadiusL),
                      ),
                    ),
                  ),
                  Positioned(
                    top: d.screenHeight * 0.015 + d.spacingM,
                    left: d.horizontalPadding,
                    child: Container(
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
                  ),
                  if (product.hasDiscount && !isOutOfStock)
                    Positioned(
                      top: d.screenHeight * 0.015 + d.spacingM + d.buttonHeight + d.spacingS, // Debajo del botón con separación
                      left: d.horizontalPadding,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: d.spacingM,
                          vertical: d.spacingS,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error.withValues(alpha: 0.7), // Mismo estilo que badge sin stock
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                        ),
                        child: Text(
                          '-${product.discountPercentage?.toInt()}%',
                          style: AppTextStyles.caption(d).copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                            fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge sin stock
                          ),
                        ),
                      ),
                    ),
                  if (isOutOfStock)
                    Positioned(
                      top: d.screenHeight * 0.015 + d.spacingM, // Misma altura que botón atrás
                      right: d.horizontalPadding, // Posición homologada
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: d.spacingM,
                          vertical: d.spacingS,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error.withValues(alpha: 0.7), // Más ligero con transparencia
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                        ),
                        child: Text(
                          'Sin Stock',
                          style: AppTextStyles.button(d).copyWith(
                            fontSize: d.fontSizeCaption,
                            color: colorScheme.onError,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Contenido scrolleable (CON InactivityDetector)
              Expanded(
                child: PrePaymentBarcodeScope(
                  child: InactivityDetector(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(d.horizontalPadding),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: d.spacingM),
                      // Nombre y precio
                      Text(
                        product.name,
                        style: AppTextStyles.title(d),
                      ),
                      SizedBox(height: d.spacingS),
                      Row(
                        children: [
                          Text(
                            '${product.currencySymbol}${product.finalPrice.toStringAsFixed(2)}',
                            style: AppTextStyles.price(d).copyWith(
                              fontSize: d.fontSizeTitle,
                            ),
                          ),
                          if (product.hasDiscount) ...[
                            SizedBox(width: d.spacingS),
                            Text(
                              '${product.currencySymbol}${product.priceAsDouble.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: d.fontSizeBody,
                                decoration: TextDecoration.lineThrough,
                                color: colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: d.spacingL),
                      // Descripción
                      Text(
                        product.description,
                        style: AppTextStyles.body(d).copyWith(
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: d.spacingL),
                      // Selector de variaciones (si el producto tiene variaciones)
                      if (product.hasVariations)
                        VariationSelector(
                          product: product,
                          onVariationSelected: (variation) {
                            print('🎯 Variación seleccionada: ${variation?.formattedAttributes}');
                          },
                        ),
                      if (product.hasVariations)
                        SizedBox(height: d.spacingL),
                      // Espacio extra para el footer fijo
                      SizedBox(height: d.spacingXL * 4),
                    ],
                  ),
                ),
              ))),
            ],
          ),
          // Bottom bar con contador y botón
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(d.horizontalPadding),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onSurface.withValues(alpha: 0.2),
                    blurRadius: d.spacingS,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Información del producto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.body(d).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: d.spacingXS),
                        Text(
                          '${product.currencySymbol}${product.finalPrice.toStringAsFixed(2)}',
                          style: AppTextStyles.price(d),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: d.spacingM),
                  // ProductCounter y botón carrito
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProductCounter(
                        quantity: quantity,
                        onIncrement: () => _handleIncrement(context, ref, quantity),
                        onDecrement: () => _handleDecrement(ref, quantity),
                        isIncrementDisabled: currentStock <= 0,
                      ),
                      if (quantity > 0) ...[
                        // Debug: Verificar que solo aparezca cuando quantity > 0
                        SizedBox(width: d.spacingS),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(CartScreen.routeName),
                          child: Container(
                            width: d.iconSizeL,
                            height: d.iconSizeL,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(d.borderRadiusS),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.shopping_cart,
                                color: colorScheme.onPrimary,
                                size: d.iconSizeM,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          LinearTimer(timer: timer),
          if (isScreenLoading)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.25),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
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
