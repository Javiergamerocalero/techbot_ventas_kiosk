import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/providers/products/variation_provider.dart';
import 'package:ventas_kiosko/providers/ui/stock_warning_provider.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/widgets/products/product_variation_selector_modal.dart';
import 'package:ventas_kiosko/screens/product_detail_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/product_counter.dart';
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  Future<void> _handleAddToCart(BuildContext context, WidgetRef ref, int quantity, int currentStock) async {
    // Si ya no hay stock local, no hacer nada (botón ya deshabilitado)
    if (currentStock <= 0) return;

    // Verificar si el producto tiene variaciones
    if (product.hasVariations && product.variations.isNotEmpty && quantity == 0) {
      if (!context.mounted) return;
      
      // Limpiar cualquier selección previa antes de abrir el modal
      ref.read(selectedVariationProvider.notifier).clearSelection(product.id);
      
      // Mostrar modal de selección de variaciones
      final selectedVariation = await ProductVariationSelectorModal.show(
        context: context,
        product: product,
      );
      
      // Si el usuario canceló, no hacer nada
      if (selectedVariation == null) {
        print('❌ Usuario canceló selección de variación para ${product.name}');
        return;
      }
      
      print('✅ Variación seleccionada para ${product.name}: ${selectedVariation.formattedAttributes}');
      
      // Agregar al carrito con la variación seleccionada
      final buttonKey = 'product_${product.id}_add';
      if (ref.read(buttonLoadingProvider.notifier).isLoading(buttonKey)) return;
      
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
        final response = await ref.read(cartNotifierProvider.notifier).validateAndAddProduct(
          product,
          quantity: 1,
          selectedVariation: selectedVariation,
        );
        
        if (!response.isAvailable) {
          final warning = ref.read(stockWarningProvider.notifier);
          final itemId = product.id.toString();
          if (!warning.hasShownWarning('product_$itemId')) {
            if (context.mounted) {
              StockValidationModal.showOutOfStock(
                context: context,
                productName: product.name,
              );
            }
            warning.markWarningShown('product_$itemId');
          }
        }
      });
      
      return;
    }

    final newTotal = quantity == 0 ? 1 : quantity + 1;
    final itemId = product.id.toString();
    final buttonKey = 'product_${product.id}_add';

    // Evitar llamadas duplicadas y mostrar spinner en botón +
    if (ref.read(buttonLoadingProvider.notifier).isLoading(buttonKey)) return;

    ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
      // Obtener el cartItem para detectar si hay variación seleccionada
      final cartItem = ref.read(productInCartProvider(product.id.toString()));
      final variationId = cartItem?.selectedVariation?.id;
      final selectedVariation = cartItem?.selectedVariation;
      
      print('🔍 ProductCard: Validando stock - Producto: ${product.name}, Cantidad: $newTotal, Variación: ${variationId ?? "ninguna"}');
      
      final response = await ref.read(cartNotifierProvider.notifier).validateStockOnly(
        product, 
        newTotal,
        variationId: variationId,
      );
      
      if (response.isAvailable) {
        if (quantity == 0) {
          // Primera vez agregando: si tiene variaciones, debe mostrar modal
          // Si no tiene variaciones, agregar directamente
          if (product.hasVariations && product.variations.isNotEmpty) {
            // Mostrar modal de selección de variaciones
            if (!context.mounted) return;
            
            final selectedVar = await ProductVariationSelectorModal.show(
              context: context,
              product: product,
            );
            
            if (selectedVar == null) {
              print('❌ Usuario canceló selección de variación');
              return;
            }
            
            // Agregar con la variación seleccionada
            await ref.read(cartNotifierProvider.notifier).validateAndAddProduct(
              product,
              quantity: 1,
              selectedVariation: selectedVar,
            );
          } else {
            // Producto sin variaciones
            ref.read(cartNotifierProvider.notifier).addProduct(product);
          }
        } else {
          // Ya existe en carrito: usar la variación que ya tiene
          ref.read(cartNotifierProvider.notifier).addProduct(
            product,
            quantity: 1,
            selectedVariation: selectedVariation,
          );
        }
        return;
      }

      // Sin stock: mostrar modal SOLO una vez por sesión
      final warning = ref.read(stockWarningProvider.notifier);
      if (!warning.hasShownWarning('product_$itemId')) {
        if (context.mounted) {
          StockValidationModal.showOutOfStock(
            context: context,
            productName: product.name,
          );
        }
        warning.markWarningShown('product_$itemId');
      }
    }).catchError((_) {
      // Silenciar errores de red para no bloquear UI
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final cartItem = ref.watch(productInCartProvider(product.id.toString()));
    final quantity = cartItem?.quantity ?? 0;
    
    // CRÍTICO: Si el producto tiene variación seleccionada en carrito, usar stock de esa variación
    final int currentStock;
    final bool isOutOfStock;
    
    if (cartItem?.selectedVariation != null) {
      // Producto con variación en carrito: usar stock de la variación específica
      final variationId = cartItem!.selectedVariation!.id;
      currentStock = ref.watch(currentProductVariationStockProvider(product.id, variationId));
      isOutOfStock = currentStock <= 0;
      print('🔍 ProductCard: Usando stock de variación $variationId para ${product.name}: $currentStock');
    } else {
      // Producto sin variación o no en carrito: usar stock general
      currentStock = ref.watch(currentProductStockProvider(product.id));
      isOutOfStock = ref.watch(isProductOutOfStockProvider(product.id));
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: product,
        );
      },
      child: Container(
        width: d.screenWidth * 0.40,
        margin: EdgeInsets.only(right: d.spacingXL),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(d.borderRadiusM),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.15),
              blurRadius: d.spacingS,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Stack(
              children: [
                CachedProductImage(
                  product: product,
                  height: d.screenWidth * 0.26, // Altura reducida para cards más compactos
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(d.borderRadiusM),
                    topRight: Radius.circular(d.borderRadiusM),
                  ),
                ),
                // Badge de descuento
                if (product.hasDiscount)
                  Positioned(
                    top: d.spacingS,
                    left: d.spacingS,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: d.spacingS,
                        vertical: d.spacingXS,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.error.withValues(alpha: 0.7), // Mismo estilo que badge sin stock
                        borderRadius: BorderRadius.circular(d.borderRadiusS),
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
                    top: product.hasDiscount ? d.spacingS + d.spacingL + d.spacingXS : d.spacingS,
                    left: d.spacingS,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: d.spacingS,
                        vertical: d.spacingXS,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.error.withValues(alpha: 0.7), // Mismo estilo que badge descuento
                        borderRadius: BorderRadius.circular(d.borderRadiusS),
                      ),
                      child: Text(
                        'Sin Stock',
                        style: AppTextStyles.caption(d).copyWith(
                          color: colorScheme.onError,
                          fontWeight: FontWeight.bold,
                          fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge descuento
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Contenido del producto
            Padding(
              padding: EdgeInsets.all(d.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nombre del producto
                  SizedBox(
                    height: d.fontSizeBody * 2.5,
                    child: Text(
                      product.name,
                      style: AppTextStyles.cardTitleSmall(d),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: d.spacingS),
                  // Descripción
                  SizedBox(
                    height: d.fontSizeCaption * 2.8,
                    child: Text(
                      product.description,
                      style: AppTextStyles.cardCaptionSmall(d),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: d.spacingM),
                  // Precio y contador - Layout fijo
                  SizedBox(
                    height: d.fontSizeBody * 2.5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Precios - Área fija
                        SizedBox(
                          width: d.screenWidth * 0.20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Precio final con precio original tachado en la misma línea
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    product.formattedPrice,
                                    style: AppTextStyles.priceSmall(d),
                                  ),
                                  if (product.hasDiscount) ...[
                                    SizedBox(width: d.spacingXS * 0.5),
                                    Text(
                                      product.formattedOriginalPrice,
                                      style: TextStyle(
                                        fontSize: d.fontSizeCaption * 0.75,
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ProductCounter(
                          quantity: quantity,
                          isIncrementDisabled: currentStock <= 0,
                          onIncrement: () {
                            _handleAddToCart(context, ref, quantity, currentStock);
                          },
                          onDecrement: () {
                            if (quantity > 1) {
                              ref.read(cartNotifierProvider.notifier).updateQuantity(product.id.toString(), quantity - 1);
                            } else {
                              ref.read(cartNotifierProvider.notifier).removeProduct(product.id.toString());
                            }
                          },
                        ),
                      ],
                    ),
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
