import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/optimized_product_list_item.dart';

/// Sección horizontal optimizada que no se refresca por cambios de stock
class OptimizedHorizontalProductsSection extends ConsumerWidget {
  final String title;
  final List<Product> products;

  const OptimizedHorizontalProductsSection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));

    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
          child: Text(
            title,
            style: AppTextStyles.sectionHeader(d),
          ),
        ),
        SizedBox(height: d.spacingM),
        SizedBox(
          height: d.screenWidth * 0.57, // Altura fija optimizada
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => SizedBox(width: d.spacingM),
            itemBuilder: (context, index) {
              final product = products[index];
              return SizedBox(
                width: d.screenWidth * 0.45,
                child: OptimizedProductListItem(product: product),
              );
            },
          ),
        ),
        SizedBox(height: d.spacingL),
      ],
    );
  }
}
