import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/categories/category.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/product_card.dart';

class CategorySection extends ConsumerWidget {
  final Category category;

  const CategorySection({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    // CRÍTICO: Usar provider con stock actualizado para consistencia
    final productsAsync = ref.watch(productsByCategoryWithStockProvider(category.id));

    return productsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (products) {
        if (products.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header de la categoría
            Padding(
              padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
              child: Row(
                children: [
                  Icon(
                    category.icon?.toFlutterIconData() ?? Icons.category,
                    color: colorScheme.primary,
                    size: d.iconSizeM,
                  ),
                  SizedBox(width: d.spacingS),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: AppTextStyles.sectionHeaderSmall(d),
                        ),
                        if (category.description != null)
                          Text(
                            category.description!,
                            style: AppTextStyles.cardCaptionSmall(d),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: d.spacingM),
            // Lista horizontal de productos
            SizedBox(
              height: d.screenWidth * 0.75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: d.horizontalPadding,
                  right: d.horizontalPadding,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
            SizedBox(height: d.spacingL),
          ],
        );
      },
    );
  }

}
