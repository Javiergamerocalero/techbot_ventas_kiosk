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
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';

class GridProductCard extends ConsumerWidget {
  final Product product;

  const GridProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final cartItem = ref.watch(productInCartProvider(product.id.toString()));
    final quantity = cartItem?.quantity ?? 0;
    
    
    // Usar stock optimizado
    final currentStock = ref.watch(productCurrentStockProvider(product.id, product.effectiveStock));
    final productWithUpdatedStock = product.copyWith(stock: currentStock);
    
    final hasDiscount = productWithUpdatedStock.hasDiscount == true;
    final isOutOfStock = currentStock <= 0;

    return Stack(
      children: [
        // Card principal
        Container(
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
                      fit: BoxFit.contain, // Mostrar imagen completa sin recortar
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
                          '-${productWithUpdatedStock.discountPercentage?.toInt()}%',
                          style: AppTextStyles.caption(d).copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                            fontSize: d.fontSizeCaption * 0.85, // Mismo tamaño que badge sin stock
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
                            fontSize: d.fontSizeCaption * 0.85,
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
            Padding(
              padding: EdgeInsets.all(d.spacingS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título con altura fija
                  SizedBox(
                    height: d.fontSizeCaption * 1.15 * 1.2 * 2 + d.spacingXS, // Altura para exactamente 2 líneas
                    child: Text(
                      product.name,
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
                            if (hasDiscount)
                              Text(
                                productWithUpdatedStock.formattedOriginalPrice,
                                style: AppTextStyles.caption(d).copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                                  fontSize: d.fontSizeCaption * 0.9,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
    final buttonKey = 'grid_product_${product.id}_add';
    
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
    
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
      final currentQuantity = ref.read(productInCartProvider(product.id.toString()))?.quantity ?? 0;
      final newTotalQuantity = currentQuantity + 1;
      
      // Validar stock antes de agregar
      final response = await ref.read(cartNotifierProvider.notifier).validateStockOnly(product, newTotalQuantity);
      
      if (response.isAvailable) {
        // Si hay stock disponible, agregar al carrito
        ref.read(cartNotifierProvider.notifier).addProduct(product, quantity: 1);
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
