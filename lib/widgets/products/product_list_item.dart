import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/screens/product_detail_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/product_counter.dart';
import 'package:ventas_kiosko/widgets/products/stock_validation_modal.dart';
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';

class ProductListItem extends ConsumerWidget {
  final Product product;

  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final cartItem = ref.watch(productInCartProvider(product.id.toString()));
    final quantity = cartItem?.quantity ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: product,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(d.borderRadiusM),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.4 * 255),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(d.spacingM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              CachedProductImage(
                product: product,
                width: 80,
                height: 80,
                borderRadius: BorderRadius.circular(d.borderRadiusS),
              ),
              SizedBox(width: d.spacingM),
              // Información del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: AppTextStyles.subtitle(d),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (product.discountPercentage != null && product.discountPercentage! > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: d.spacingS,
                              vertical: d.spacingXS,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.error.withValues(alpha: 0.7), // Mismo estilo que badge sin stock
                              borderRadius: BorderRadius.circular(d.borderRadiusS),
                            ),
                            child: Text(
                              '-${product.discountPercentage!.toInt()}%',
                              style: AppTextStyles.caption(d).copyWith(
                                color: colorScheme.onError,
                                fontWeight: FontWeight.bold,
                                fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge sin stock
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: d.spacingXS),
                    if (product.description.isNotEmpty)
                      Text(
                        product.description,
                        style: AppTextStyles.caption(d),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    SizedBox(height: d.spacingS),
                    // Precio y contador
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.discountPercentage != null && product.discountPercentage! > 0)
                              Text(
                                '\$${product.priceAsDouble.toStringAsFixed(2)}',
                                style: AppTextStyles.caption(d).copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.grey,
                                ),
                              ),
                            Text(
                              '\$${product.finalPrice.toStringAsFixed(2)}',
                              style: AppTextStyles.subtitle(d).copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ProductCounter(
                          quantity: quantity,
                          isIncrementDisabled: product.effectiveStock <= 0,
                          onIncrement: () async {
                            // Verificar stock local primero
                            if (product.effectiveStock == 0) {
                              if (context.mounted) {
                                StockValidationModal.showOutOfStock(
                                  context: context,
                                  productName: product.name,
                                  customMessage: 'Producto agotado',
                                );
                              }
                              return;
                            }
                            
                            final newTotalQuantity = quantity + 1;
                            
                            if (quantity == 0) {
                              // Si no hay producto en carrito, usar validateAndAddProduct
                              final stockResponse = await ref
                                  .read(cartNotifierProvider.notifier)
                                  .validateAndAddProduct(product, quantity: 1);
                              
                              if (!stockResponse.isAvailable) {
                                if (context.mounted) {
                                  StockValidationModal.showOutOfStock(
                                    context: context,
                                    productName: product.name,
                                    customMessage: stockResponse.message,
                                  );
                                }
                              }
                            } else {
                              // Si ya hay producto, solo validar la nueva cantidad total sin agregar
                              final stockResponse = await ref
                                  .read(cartNotifierProvider.notifier)
                                  .validateStockOnly(product, newTotalQuantity);
                              
                              if (stockResponse.isAvailable) {
                                // Si la validación es exitosa, actualizar la cantidad local
                                ref.read(cartNotifierProvider.notifier).updateQuantity(product.id.toString(), newTotalQuantity);
                              } else {
                                if (context.mounted) {
                                  if (stockResponse.availableStock > 0) {
                                    StockValidationModal.showInsufficientStock(
                                      context: context,
                                      productName: product.name,
                                      availableStock: stockResponse.availableStock,
                                    );
                                  } else {
                                    StockValidationModal.showOutOfStock(
                                      context: context,
                                      productName: product.name,
                                      customMessage: stockResponse.message,
                                    );
                                  }
                                }
                              }
                            }
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
