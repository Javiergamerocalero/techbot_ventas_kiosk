import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/config/icon_data.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/providers/categories/subcategories_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class SubcategoryFilterChips extends ConsumerWidget {
  const SubcategoryFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final selectedCategory = ref.watch(selectedCategoryFilterProvider);
    final selectedSubcategory = ref.watch(selectedSubcategoryFilterProvider);
    
    if (selectedCategory == null) {
      return const SizedBox.shrink();
    }

    final subcategories = ref.watch(subcategoriesForSelectedCategoryProvider(selectedCategory));

    if (subcategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: d.spacingXL * 1.5,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
            itemCount: subcategories.length,
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              final isSelected = selectedSubcategory == subcategory.id;
              
              return Padding(
                padding: EdgeInsets.only(right: d.spacingM),
                child: FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        subcategory.icon?.toFlutterIconData() ?? Icons.category,
                        size: d.iconSizeS,
                        color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                      ),
                      SizedBox(width: d.spacingS),
                      Text(
                        subcategory.name,
                        style: AppTextStyles.cardCaptionSmall(d).copyWith(
                          color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(selectedSubcategoryFilterProvider.notifier).selectSubcategory(subcategory.id);
                      // Reiniciar paginación al cambiar a subcategoría
                      ref.read(globalProductsPaginationProvider.notifier).resetAll();
                    } else {
                      ref.read(selectedSubcategoryFilterProvider.notifier).clearSubcategory();
                      // Reiniciar paginación al limpiar subcategoría
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
        SizedBox(height: d.spacingS),
      ],
    );
  }

}
