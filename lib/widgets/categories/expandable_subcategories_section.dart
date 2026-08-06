import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/categories/category.dart';
import 'package:ventas_kiosko/models/categories/subcategory.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/category_products_grid.dart';

class ExpandableSubcategoriesSection extends ConsumerWidget {
  final Category category;

  const ExpandableSubcategoriesSection({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final subcategoriesAsync = ref.watch(subcategoriesByCategoryProvider(category.id));
    final isExpanded = ref.watch(categoryProductsExpandedProvider.select((state) => state[category.id.toString()] ?? false));

    return subcategoriesAsync.when(
      loading: () => Padding(
        padding: EdgeInsets.symmetric(vertical: d.spacingM),
        child: Center(
          child: SizedBox(
            height: d.iconSizeM,
            width: d.iconSizeM,
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
      data: (subcategories) {
        if (subcategories.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: d.spacingL), // Más espacio entre título y productos
            // Mostrar subcategorías según el estado expandido (sin animación para evitar issues de layout)
            if (isExpanded)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: subcategories
                    .map((subcategory) => SubcategoryProductsSection(subcategory: subcategory))
                    .toList(),
              )
            else
              _buildPreviewSection(d, colorScheme, subcategories, ref),
          ],
        );
      },
    );
  }

  Widget _buildPreviewSection(AppDimensions d, ColorScheme colorScheme, List<Subcategory> subcategories, WidgetRef ref) {
    // Obtener todos los productos de todas las subcategorías
    final allProducts = <Product>[];
    for (final subcategory in subcategories) {
      if (subcategory.products.isNotEmpty) {
        allProducts.addAll(subcategory.products);
      }
    }
    
    final previewProducts = allProducts.take(4).toList();
    
    if (previewProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Grid de productos preview
        CategoryProductsGrid(
          products: previewProducts,
          maxItems: previewProducts.length,
        ),
        if (allProducts.length > 4) ...[
          SizedBox(height: d.spacingXL),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
            child: GestureDetector(
              onTap: () => ref.read(categoryProductsExpandedProvider.notifier).toggleExpanded(category.id.toString()),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: d.spacingM),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(d.borderRadiusM),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ver todas las subcategorías (${subcategories.length})',
                      style: AppTextStyles.button(d).copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: d.spacingS),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: colorScheme.primary,
                      size: d.iconSizeM,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class SubcategoryProductsSection extends ConsumerWidget {
  final Subcategory subcategory;
  
  const SubcategoryProductsSection({
    super.key,
    required this.subcategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final products = subcategory.products;

    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header de la subcategoría
        Padding(
          padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
          child: Row(
            children: [
              SizedBox(width: d.spacingM), // Indentación para subcategoría
              Icon(
                subcategory.icon?.toFlutterIconData() ?? Icons.category_outlined,
                color: colorScheme.secondary,
                size: d.iconSizeS,
              ),
              SizedBox(width: d.spacingS),
              Expanded(
                child: Text(
                  subcategory.name,
                  style: AppTextStyles.sectionHeaderSmall(d).copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: d.spacingL), // Más espacio entre título y productos
        // Grid de productos de la subcategoría
        CategoryProductsGrid(
          products: products,
          maxItems: products.length,
        ),
        SizedBox(height: d.spacingL),
      ],
    );
  }
}
