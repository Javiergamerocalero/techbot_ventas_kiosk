import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/screens/product_detail_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/providers/ui/stock_warning_provider.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/widgets/products/product_variation_selector_modal.dart';
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';
import 'package:ventas_kiosko/providers/products/variation_provider.dart';

class FeaturedProductCard extends ConsumerWidget {
  final Product product;
  final double? width;

  const FeaturedProductCard({
    super.key,
    required this.product,
    this.width,
  });

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
      print('🔍 FeaturedProductCard: Usando stock de variación $variationId para ${product.name}: $currentStock');
    } else {
      // Producto sin variación o no en carrito: usar stock general
      currentStock = ref.watch(currentProductStockProvider(product.id));
      isOutOfStock = ref.watch(isProductOutOfStockProvider(product.id));
    }
    
    final productWithUpdatedStock = product.copyWith(stock: currentStock);
    final hasDiscount = productWithUpdatedStock.hasDiscount == true;

    return Stack(
      children: [
        // Card principal
        Container(
          width: width ?? d.screenWidth * 0.42,
          margin: EdgeInsets.only(right: d.spacingL),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(d.borderRadiusM),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.2),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              Stack(
                children: [
                  // Contenedor con fondo blanco para mejor contraste
                  Container(
                    height: d.screenWidth * 0.28, // Altura reducida para cards más compactos
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo blanco para mejor contraste
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(d.borderRadiusM),
                        topRight: Radius.circular(d.borderRadiusM),
                      ),
                    ),
                    child: CachedProductImage(
                      product: productWithUpdatedStock,
                      height: d.screenWidth * 0.28, // Altura reducida para cards más compactos
                      width: double.infinity,
                      fit: BoxFit.contain, 
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(d.borderRadiusM),
                        topRight: Radius.circular(d.borderRadiusM),
                      ),
                    ),
                  ),
                  // Badge de descuento
                  if (hasDiscount && !isOutOfStock)
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
                          '-${productWithUpdatedStock.discountPercentage?.toInt() ?? 0}%',
                          style: AppTextStyles.caption(d).copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                            fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge sin stock
                          ),
                        ),
                      ),
                    ),
                  // Badge de sin stock (prioridad sobre descuento)
                  if (isOutOfStock)
                    Positioned(
                      top: d.spacingS,
                      left: d.spacingS,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: d.spacingS,
                          vertical: d.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error.withValues(alpha: 0.7), // Más ligero con transparencia
                          borderRadius: BorderRadius.circular(d.borderRadiusS),
                        ),
                        child: Text(
                          'Sin Stock',
                          style: AppTextStyles.caption(d).copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                            fontSize: d.fontSizeCaption * 0.9,
                          ),
                        ),
                      ),
                    ),
                  // Indicador de cantidad en carrito
                  if (quantity > 0)
                    Positioned(
                      top: d.spacingS,
                      right: d.spacingS,
                      child: Container(
                        width: d.iconSizeM,
                        height: d.iconSizeM,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            quantity.toString(),
                            style: AppTextStyles.caption(d).copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Contenido del producto
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(d.spacingS),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Expanded(
                        flex: 2,
                        child: Text(
                          productWithUpdatedStock.name,
                          style: AppTextStyles.cardTitleSmall(d).copyWith(
                            fontSize: d.fontSizeCaption * 1.15,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: d.spacingXS * 0.5),
                      // Fila de precio y botón
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Precios
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Precio final
                                Text(
                                  productWithUpdatedStock.formattedPrice,
                                  style: AppTextStyles.priceSmall(d).copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                    fontSize: d.fontSizeCaption * 1.1,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Precio original (si hay descuento)
                                if (hasDiscount)
                                  Text(
                                    productWithUpdatedStock.formattedOriginalPrice,
                                    style: AppTextStyles.caption(d).copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                                      fontSize: d.fontSizeCaption * 0.9,
                                    ),
                                    maxLines: 1,
                                  ),
                              ],
                            ),
                          ),
                          // Botón agregar mejorado
                          GestureDetector(
                            onTap: isOutOfStock ? null : () => _handleAddToCart(ref, context),
                            child: Container(
                              width: d.iconSizeL, // Tamaño aumentado
                              height: d.iconSizeL,
                              decoration: BoxDecoration(
                                color: isOutOfStock 
                                    ? colorScheme.onSurface.withValues(alpha: 0.3)
                                    : colorScheme.primary,
                                borderRadius: BorderRadius.circular(d.borderRadiusS),
                                boxShadow: isOutOfStock ? null : [
                                  BoxShadow(
                                    color: colorScheme.primary.withValues(alpha: 0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add, // Siempre ícono '+'
                                color: isOutOfStock 
                                    ? colorScheme.onSurface.withValues(alpha: 0.5) // Gris cuando no hay stock
                                    : colorScheme.onPrimary, // Blanco cuando hay stock
                                size: d.iconSizeM,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // GestureDetector para navegación (cubre toda la card excepto el botón)
        Positioned(
          top: 0,
          left: 0,
          right: d.iconSizeL + d.spacingS, // Excluir solo el ancho del botón
          bottom: d.iconSizeL + d.spacingS, // Excluir solo el alto del botón
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductDetailScreen.routeName,
                arguments: product,
              );
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAddToCart(WidgetRef ref, BuildContext context) async {
    final buttonKey = 'featured_product_${product.id}_add';
    
    // Verificar si ya hay una operación en progreso
    if (ref.read(buttonLoadingProvider.notifier).isLoading(buttonKey)) {
      return;
    }
    
    final itemId = product.id.toString();
    final currentStock = ref.read(productCurrentStockProvider(product.id, product.effectiveStock));
    
    // Si no hay stock local, mostrar modal amigable UNA sola vez
    if (currentStock <= 0) {
      final warning = ref.read(stockWarningProvider.notifier);
      if (!warning.hasShownWarning('product_$itemId')) {
        if (context.mounted) {
          await StockValidationModal.showOutOfStock(
            context: context,
            productName: product.name,
          );
        }
        warning.markWarningShown('product_$itemId');
      }
      return;
    }
    
    // Verificar si el producto tiene variaciones
    final currentQuantity = ref.read(productInCartProvider(product.id.toString()))?.quantity ?? 0;
    if (product.hasVariations && product.variations.isNotEmpty && currentQuantity == 0) {
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
      try {
        await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
          final response = await ref.read(cartNotifierProvider.notifier).validateAndAddProduct(
            product,
            quantity: 1,
            selectedVariation: selectedVariation,
          );
          
          if (!response.isAvailable) {
            final warning = ref.read(stockWarningProvider.notifier);
            if (!warning.hasShownWarning('product_$itemId')) {
              if (context.mounted) {
                await StockValidationModal.showOutOfStock(
                  context: context,
                  productName: product.name,
                );
              }
              warning.markWarningShown('product_$itemId');
            }
          }
        });
      } catch (e) {
        if (e.toString().contains('Operation already in progress')) {
          return;
        }
      }
      
      return;
    }
    
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
      final newTotalQuantity = currentQuantity + 1;
      
      // Obtener el cartItem para detectar si hay variación seleccionada
      final cartItem = ref.read(productInCartProvider(product.id.toString()));
      final variationId = cartItem?.selectedVariation?.id;
      final selectedVariation = cartItem?.selectedVariation;
      
      print('🔍 FeaturedProductCard: Validando stock - Producto: ${product.name}, Cantidad: $newTotalQuantity, Variación: ${variationId ?? "ninguna"}');
      
      // Validar stock antes de agregar
      final response = await ref.read(cartNotifierProvider.notifier).validateStockOnly(
        product, 
        newTotalQuantity,
        variationId: variationId,
      );
      
      if (response.isAvailable) {
        // Si hay stock disponible, agregar al carrito con la variación que ya tiene
        ref.read(cartNotifierProvider.notifier).addProduct(
          product, 
          quantity: 1,
          selectedVariation: selectedVariation,
        );
      } else {
        // Si no hay stock disponible, mostrar modal amigable UNA sola vez
        final warning = ref.read(stockWarningProvider.notifier);
        if (!warning.hasShownWarning('product_$itemId')) {
          if (context.mounted) {
            await StockValidationModal.showOutOfStock(
              context: context,
              productName: product.name,
            );
          }
          warning.markWarningShown('product_$itemId');
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
}
