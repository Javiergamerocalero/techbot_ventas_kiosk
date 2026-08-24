import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/categories/category.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/category_products_grid.dart';
import 'package:ventas_kiosko/widgets/categories/expandable_subcategories_section.dart';

class CategoryProductsSection extends ConsumerWidget {
  final Category category;

  const CategoryProductsSection({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    
    // Si la categoría no tiene productos directos, usar vista expandible de subcategorías
    if (category.products.isEmpty && category.subCategories.isNotEmpty) {
      return ExpandableSubcategoriesSection(category: category);
    }
    
    // Si tiene productos directos, mostrar la vista normal
    final productsByCategoryAsync = ref.watch(productsByCategoryWithStockProvider(category.id));

    return productsByCategoryAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
      data: (products) {
        if (products.isEmpty) {
          return const SizedBox.shrink();
        }

        // Per Javier 2026-08-24: sin paginado. Mostrar TODOS los
        // productos de la categoría — el scroll de la pantalla los
        // recorre. Antes tomábamos `visibleCount` (default 4) y
        // sumábamos botón "Ver más productos (N)".
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
                          style: AppTextStyles.sectionHeader(d),
                        ),
                        if (category.description != null)
                          Text(
                            category.description!,
                            style: AppTextStyles.caption(d),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: d.spacingL),
            CategoryProductsGrid(
              products: products,
              maxItems: products.length,
            ),
            SizedBox(height: d.spacingXL),
          ],
        );
      },
    );
  }
}
