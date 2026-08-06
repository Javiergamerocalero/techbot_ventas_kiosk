import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class ProductListCard extends ConsumerWidget {
  final Product product;

  const ProductListCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final cartItem = ref.watch(productInCartProvider(product.id.toString()));
    final quantity = cartItem?.quantity ?? 0;
    
    final hasDiscount = product.hasDiscount == true;

    return Container(
      margin: EdgeInsets.only(bottom: d.spacingM),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Imagen del producto
          Stack(
            children: [
              Container(
                width: d.screenWidth * 0.24,
                height: d.screenWidth * 0.24,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.fastfood_outlined,
                  size: d.iconSizeL,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              if (hasDiscount)
                Positioned(
                  top: d.spacingXS,
                  left: d.spacingXS,
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
                      '-${product.discountPercentage}%',
                      style: AppTextStyles.caption(d).copyWith(
                        color: colorScheme.onError,
                        fontWeight: FontWeight.bold,
                        fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge sin stock
                      ),
                    ),
                  ),
                ),
              if (quantity > 0)
                Positioned(
                  top: d.spacingXS,
                  right: d.spacingXS,
                  child: Container(
                    width: d.iconSizeS * 1.2,
                    height: d.iconSizeS * 1.2,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        quantity.toString(),
                        style: AppTextStyles.cardCaptionSmall(d).copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: d.spacingM),
          // Información del producto
          Expanded(
            child: Container(
              height: d.screenWidth * 0.24,
              padding: EdgeInsets.fromLTRB(
                d.spacingM,
                d.spacingS,
                d.spacingM,
                d.spacingM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    product.name,
                    style: AppTextStyles.cardTitleSmall(d),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: d.spacingXS),
                  // Descripción con altura fija
                  Expanded(
                    child: Text(
                      product.description.length > 40 
                          ? '${product.description.substring(0, 40)}...'
                          : product.description,
                      style: AppTextStyles.cardCaptionSmall(d),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Precio - Posición fija
                  Row(
                    children: [
                      if (hasDiscount) ...[
                        Text(
                          '\$${product.priceAsDouble.toStringAsFixed(2)}',
                          style: AppTextStyles.cardCaptionSmall(d).copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                        SizedBox(width: d.spacingS),
                      ],
                      Text(
                        '\$${product.finalPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.priceSmall(d),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Botón de agregar
          Padding(
            padding: EdgeInsets.all(d.spacingM),
            child: GestureDetector(
              onTap: () {
                if (quantity == 0) {
                  ref.read(cartNotifierProvider.notifier).addProduct(product);
                } else {
                  ref.read(cartNotifierProvider.notifier).updateQuantity(product.id.toString(), quantity + 1);
                }
              },
              child: Container(
                width: d.iconSizeL,
                height: d.iconSizeL,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: colorScheme.onPrimary,
                  size: d.iconSizeM,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
