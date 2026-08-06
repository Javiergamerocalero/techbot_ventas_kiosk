import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/categories/categories_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class CategoryFilterChips extends ConsumerWidget {
  const CategoryFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryFilterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        categoriesAsync.when(
          data: (categories) => SizedBox(
            height: d.spacingXL * 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category.id;
                
                return Padding(
                  padding: EdgeInsets.only(right: d.spacingM),
                  child: FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category.icon?.toFlutterIconData() ?? Icons.category,
                          size: d.iconSizeS,
                          color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                        ),
                        SizedBox(width: d.spacingS),
                        Text(
                          category.name,
                          style: AppTextStyles.caption(d).copyWith(
                            color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(selectedCategoryFilterProvider.notifier).selectCategory(category.id);
                        ref.read(selectedSubcategoryFilterProvider.notifier).clearSubcategory();
                        // Reiniciar paginación al cambiar filtro
                        ref.read(globalProductsPaginationProvider.notifier).resetAll();
                      } else {
                        ref.read(selectedCategoryFilterProvider.notifier).clearCategory();
                        ref.read(selectedSubcategoryFilterProvider.notifier).clearSubcategory();
                        // Reiniciar paginación al limpiar filtros
                      }
                    },
                    selectedColor: colorScheme.primary,
                    backgroundColor: colorScheme.surface,
                    side: BorderSide(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: d.spacingM,
                      vertical: d.spacingS,
                    ),
                  ),
                );
              },
            ),
          ),
          loading: () => SizedBox(
            height: d.spacingXL * 2,
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => SizedBox(
            height: d.spacingXL * 2,
            child: Center(child: Text('Error: $err')),
          ),
        ),
        SizedBox(height: d.spacingS),
      ],
    );
  }

}
