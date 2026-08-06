import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/featured_product_card.dart';

class HorizontalProductsSection extends ConsumerWidget {
  final String title;
  final List<Product> products;

  const HorizontalProductsSection({
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
          height: (d.screenWidth * 0.42) / 0.85, // Altura reducida para cards más compactos (0.85 vs 0.75)
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return FeaturedProductCard(
                product: products[index],
                width: d.screenWidth * 0.42, // Ancho aumentado para mostrar solo 2 cards por pantalla
              );
            },
          ),
        ),
        SizedBox(height: d.spacingXL),
      ],
    );
  }
}
