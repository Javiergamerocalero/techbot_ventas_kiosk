import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/screens/time_up_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';
import 'package:ventas_kiosko/widgets/utils/inactivity_detector.dart';
import 'package:ventas_kiosko/widgets/products/product_counter.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/widgets/images/combo_image_carousel.dart';
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/providers/ui/stock_warning_provider.dart';
import 'package:ventas_kiosko/widgets/combos/combo_variation_selector_modal.dart';
import '../screens/cart_screen.dart';

class ComboDetailScreen extends ConsumerWidget {
  static const routeName = '/combo-detail';
  final Combo combo;
  
  const ComboDetailScreen({
    super.key,
    required this.combo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final timer = ref.watch(timerProvider);
    final cartItem = ref.watch(comboInCartProvider(combo.id.toString()));
    final quantity = cartItem?.quantity ?? 0;
    
    // Verificar si el combo está agotado basado en sus productos
    final isOutOfStock = combo.isOutOfStock;
    
    // Loader global de pantalla (increment/decrement)
    final isIncLoading = ref.watch(buttonIsLoadingProvider('combo_${combo.id}_increment'));
    final isDecLoading = ref.watch(buttonIsLoadingProvider('combo_${combo.id}_decrement'));
    final isScreenLoading = isIncLoading || isDecLoading;
    // Altura exacta del LinearTimer (1% del alto de pantalla)
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
                  // Carousel de imágenes con espacio exacto del timer
                  Padding(
                    padding: EdgeInsets.only(top: timerHeight),
                    child: ComboImageCarousel(
                      combo: combo,
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
                  if (isOutOfStock)
                    Positioned(
                      top: d.screenHeight * 0.015 + d.spacingM, 
                      right: d.horizontalPadding, 
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
                child: InactivityDetector(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(d.horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: d.spacingM),
                      // Nombre y precio
                      Text(
                        combo.name,
                        style: AppTextStyles.title(d),
                      ),
                      SizedBox(height: d.spacingS),
                      Row(
                        children: [
                          Text(
                            combo.formattedPrice,
                            style: AppTextStyles.price(d).copyWith(
                              fontSize: d.fontSizeTitle,
                            ),
                          ),
                          if (combo.hasDiscount) ...[
                            SizedBox(width: d.spacingS),
                            Text(
                              combo.formattedOriginalPrice,
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
                        combo.description,
                        style: AppTextStyles.body(d).copyWith(
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: d.spacingL),
                      // Productos incluidos en el combo
                      if (combo.products.isNotEmpty) ...[
                        Text(
                          'Productos incluidos',
                          style: AppTextStyles.subtitle(d),
                        ),
                        SizedBox(height: d.spacingM),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(d.spacingM),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(d.borderRadiusM),
                            border: Border.all(color: colorScheme.outline),
                          ),
                          child: Column(
                            children: combo.products.map((product) => 
                              _buildComboProductItem(d, colorScheme, product)
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: d.spacingL),
                      ],
                      // Información adicional del combo
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(d.spacingM),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(d.borderRadiusM),
                          border: Border.all(color: colorScheme.outline),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Información del combo',
                              style: AppTextStyles.subtitle(d),
                            ),
                            SizedBox(height: d.spacingM),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: colorScheme.secondary,
                                  size: d.iconSizeS,
                                ),
                                SizedBox(width: d.spacingS),
                                Expanded(
                                  child: Text(
                                    'Todos los productos están incluidos',
                                    style: AppTextStyles.body(d),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: d.spacingS),
                            Row(
                              children: [
                                Icon(
                                  Icons.savings,
                                  color: colorScheme.primary,
                                  size: d.iconSizeS,
                                ),
                                SizedBox(width: d.spacingS),
                                Expanded(
                                  child: Text(
                                    'Precio especial por combo',
                                    style: AppTextStyles.body(d),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: d.spacingXL * 4),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (combo.hasDiscount && !isOutOfStock)
            Positioned(
              top: d.spacingXL * 3, 
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
                  '-${combo.discountPercentage?.toInt()}%',
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.onError,
                    fontWeight: FontWeight.bold,
                    fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge sin stock
                  ),
                ),
              ),
            ),
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
                  // Información del combo
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          combo.name,
                          style: AppTextStyles.body(d).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: d.spacingXS),
                        Text(
                          combo.formattedPrice,
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
                        isIncrementDisabled: isOutOfStock,
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
          
          
          // Timer
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

  Future<void> _handleIncrement(BuildContext context, WidgetRef ref, int currentQuantity) async {
    if (combo.isOutOfStock) {
      final warning = ref.read(stockWarningProvider.notifier);
      final key = 'combo_${combo.id}';
      if (!warning.hasShownWarning(key)) {
        if (!context.mounted) return;
        await StockValidationModal.showOutOfStock(
          context: context,
          productName: combo.name,
        );
        warning.markWarningShown(key);
      }
      return;
    }
    
    // Verificar si el combo tiene productos con variaciones
    final hasProductsWithVariations = combo.products.any(
      (product) => product.hasVariations && product.variations.isNotEmpty
    );
    
    // Si es la primera vez agregando y hay productos con variaciones, mostrar modal
    if (currentQuantity == 0 && hasProductsWithVariations) {
      if (!context.mounted) return;
      
      final variationSelections = await ComboVariationSelectorModal.show(
        context: context,
        combo: combo,
      );
      
      // Si el usuario canceló la selección, no hacer nada
      if (variationSelections == null) {
        print('❌ Usuario canceló selección de variaciones para combo ${combo.name}');
        return;
      }
      
      print('✅ Variaciones seleccionadas para combo ${combo.name}: $variationSelections');
      
    }
    
    final buttonKey = 'combo_${combo.id}_increment';
    
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
        final newTotalQuantity = currentQuantity + 1;
        
        if (currentQuantity == 0) {
          final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(combo.id.toString(), 1);
          
          // Si el combo no existe en carrito, agregarlo manualmente después de validación exitosa
          if (response.isAvailable) {
            final existingCombo = ref.read(cartNotifierProvider).comboItems.where((item) => item.combo.id == combo.id).firstOrNull;
            if (existingCombo == null) {
              ref.read(cartNotifierProvider.notifier).addCombo(combo, quantity: 1);
            }
          } else {
            // Modal amigable una sola vez por combo
            final warning = ref.read(stockWarningProvider.notifier);
            final key = 'combo_${combo.id}';
            if (!warning.hasShownWarning(key)) {
              if (!context.mounted) return;
              await StockValidationModal.showOutOfStock(
                context: context,
                productName: combo.name,
              );
              warning.markWarningShown(key);
            }
          }
          
        } else {
          final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(combo.id.toString(), newTotalQuantity);
          
          if (!response.isAvailable) {
            final warning = ref.read(stockWarningProvider.notifier);
            final key = 'combo_${combo.id}';
            if (!warning.hasShownWarning(key)) {
              if (!context.mounted) return;
              await StockValidationModal.showOutOfStock(
                context: context,
                productName: combo.name,
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
      
    }
  }

  /// Maneja el decremento de cantidad
  Future<void> _handleDecrement(WidgetRef ref, int currentQuantity) async {
    final buttonKey = 'combo_${combo.id}_decrement';
    
    if (currentQuantity <= 0) return;
    
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
        if (currentQuantity > 1) {
          final newQuantity = currentQuantity - 1;
          final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(combo.id.toString(), newQuantity);
          if (!response.isAvailable) {
            // Si hay error, mantener cantidad actual
            print('⚠️ ComboDetailScreen: Error decrementando combo: ${response.message}');
          }
        } else {
          // Remover combo completamente
          ref.read(cartNotifierProvider.notifier).removeCombo(combo.id.toString());
        }
      });
    } catch (e) {
      // Si la operación ya está en progreso, ignorar silenciosamente
      if (e.toString().contains('Operation already in progress')) {
        return;
      }
      
      print('💥 ComboDetailScreen: Exception decrementando combo: $e');
    }
  }

  Widget _buildComboProductItem(AppDimensions d, ColorScheme colorScheme, Product product) {
    return Container(
      margin: EdgeInsets.only(bottom: d.spacingM),
      child: Row(
        children: [
          // Imagen del producto
          Container(
            width: d.screenWidth * 0.15,
            height: d.screenWidth * 0.15,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(d.borderRadiusM),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(d.borderRadiusM),
              child: CachedProductImage(
                product: product,
                width: d.screenWidth * 0.15,
                height: d.screenWidth * 0.15,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: d.spacingM),
          // Información del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.body(d).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: d.spacingXS),
                Text(
                  product.description,
                  style: AppTextStyles.caption(d),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Badge de stock del producto individual (más pequeño y mejor posicionado)
          if (product.effectiveStock <= 0)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: d.spacingXS,
                vertical: d.spacingXS * 0.5,
              ),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(d.borderRadiusS),
              ),
              child: Text(
                'Sin Stock',
                style: TextStyle(
                  color: colorScheme.onError,
                  fontSize: d.fontSizeCaption * 0.7,
                  fontWeight: FontWeight.w600,
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
