import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/widgets/products/grid_product_card.dart';

class CategoryProductsGrid extends ConsumerWidget {
  final List<Product> products;
  final int maxItems;

  const CategoryProductsGrid({
    super.key,
    required this.products,
    this.maxItems = 4,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayProducts = products.take(maxItems).toList();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final spacing = d.spacingL;
          final itemWidth = (constraints.maxWidth - spacing) / 2;
          return Wrap(
            spacing: spacing,
            runSpacing: d.spacingL,
            children: List.generate(displayProducts.length, (index) {
              return SizedBox(
                width: itemWidth,
                child: GridProductCard(
                  product: displayProducts[index],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
