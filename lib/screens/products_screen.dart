import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/combos/combo_provider.dart';
import 'package:ventas_kiosko/screens/cart_screen.dart';
import 'package:ventas_kiosko/providers/categories/categories_provider.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/screens/time_up_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/horizontal_products_section.dart';
import 'package:ventas_kiosko/widgets/combos/horizontal_combos_section.dart';
import 'package:ventas_kiosko/widgets/categories/category_filter_chips.dart';
import 'package:ventas_kiosko/widgets/categories/subcategory_filter_chips.dart';
import 'package:ventas_kiosko/widgets/categories/category_products_section.dart';
import 'package:ventas_kiosko/widgets/products/category_products_grid.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';
import 'package:ventas_kiosko/widgets/utils/inactivity_detector.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/widgets/barcode/pre_payment_barcode_scope.dart';

class ProductsScreen extends ConsumerWidget {
  static const routeName = '/products';
  
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final timer = ref.watch(timerProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final featuredProductsAsync = ref.watch(featuredProductsStableProvider);
    final featuredCombosAsync = ref.watch(featuredCombosProvider);
    final totalItems = ref.watch(cartTotalItemsProvider);
    final selectedCategory = ref.watch(selectedCategoryFilterProvider);
    final selectedSubcategory = ref.watch(selectedSubcategoryFilterProvider);
    final showCategoryFilters = categoriesAsync.maybeWhen(
      data: (categories) => categories.length > 1,
      orElse: () => false,
    );
    final filteredProductsAsync = ref.watch(filteredProductsPaginatedProvider);
    final loadingMap = ref.watch(buttonLoadingProvider);
    final isActionLoading = loadingMap.entries.any((e) {
      if (e.value != true) return false;
      final k = e.key;
      return k.startsWith('product_') ||
             k.startsWith('featured_product_') ||
             k.startsWith('grid_product_') ||
             k.startsWith('featured_combo_');
    });

    handleTimer(context, ref, timer);

    final isLoading = categoriesAsync.isLoading || 
                     featuredProductsAsync.isLoading || 
                     featuredCombosAsync.isLoading;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: PrePaymentBarcodeScope(
        child: InactivityDetector(
        child: Stack(
              children: [
                // Contenido principal con padding top para el header
                isLoading 
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: colorScheme.primary,
                            strokeWidth: 3,
                          ),
                          SizedBox(height: d.spacingL),
                          Text(
                            'Cargando menú...',
                            style: AppTextStyles.body(d).copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      key: const PageStorageKey('products_scroll'),
                      child: Column(
                        children: [
                          // Espacio para el header fijo. Per Javier
                          // 2026-08-24: alinear productos arriba —
                          // achicamos el gap post-header y quitamos
                          // el spacingM extra que empujaba todo hacia
                          // abajo.
                          SizedBox(
                            height: d.screenHeight * 0.06 +
                                d.appBarHeight * 1.4,
                          ),
                          featuredProductsAsync.when(
                            data: (products) => HorizontalProductsSection(
                              title: 'Más vendidos',
                              products: products,
                            ),
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => Center(child: Text('Error: $error')),
                          ),
                          // Sección de combos activos
                          featuredCombosAsync.when(
                            data: (combos) => HorizontalCombosSection(
                              title: 'Combos especiales',
                              combos: combos,
                            ),
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => Center(child: Text('Error: $error')),
                          ),
                          // El filtro de categorías solo aparece cuando hay
                          // más de una: con una sola no filtra nada y deja un
                          // hueco entre el encabezado y los productos
                          // (Javier, 2026-09-14). Los espaciados van cortos
                          // para que el grid quede arriba (Javier, 2026-08-24).
                          if (showCategoryFilters) ...[
                            SizedBox(height: d.spacingS),
                            const CategoryFilterChips(),
                            const SubcategoryFilterChips(),
                            SizedBox(height: d.spacingS),
                          ],
                          // Mostrar productos filtrados si hay filtros activos
                          if (selectedCategory != null || selectedSubcategory != null)
                        filteredProductsAsync.when(
                          data: (products) => products.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.all(d.spacingXL),
                                  child: Center(
                                    child: Text(
                                      'No se encontraron productos',
                                      style: AppTextStyles.body(d),
                                    ),
                                  ),
                                )
                              // Per Javier 2026-08-24: sin paginado.
                              // Mostrar todos los productos filtrados
                              // en una sola grilla scrolleable.
                              : CategoryProductsGrid(
                                  products: products,
                                  maxItems: products.length,
                                ),
                          loading: () => Padding(
                            padding: EdgeInsets.all(d.spacingXL),
                            child: Center(
                              child: SizedBox(
                                height: d.iconSizeL,
                                width: d.iconSizeL,
                                child: CircularProgressIndicator(
                                  color: colorScheme.primary,
                                  strokeWidth: d.borderWidth,
                                ),
                              ),
                            ),
                          ),
                          error: (error, stack) => Center(child: Text('Error: $error')),
                        )
                      // Mostrar secciones por categoría si no hay filtros activos
                      else
                        ...categoriesAsync.when(
                          data: (categories) => categories.expand((category) => [
                            CategoryProductsSection(category: category),
                            SizedBox(height: d.spacingXL), // Espaciado adicional entre categorías
                          ]),
                          loading: () => [const SizedBox.shrink()],
                          error: (err, stack) => [Center(child: Text('Error: $err'))],
                        ),
                      SizedBox(height: d.spacingXL),
                    ],
                  ),
                ),
            // Header fijo posicionado encima
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.onSurface.withValues(alpha: 0.1),
                      blurRadius: d.spacingS,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: d.screenHeight * 0.06),
                    Container(
                      height: d.appBarHeight * 1.4,
                      padding: EdgeInsets.only(
                        left: d.horizontalPadding,
                        right: d.horizontalPadding,
                        top: d.spacingXS * 0.4,
                        bottom: d.spacingXS / 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo a la izquierda
                          Image.asset(
                            'assets/images/logo_grey.png',
                            height: d.imageSizeL * 1.8,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: d.spacingM),
                    // Textos del menú
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nuestro Menú',
                            style: AppTextStyles.title(d),
                          ),
                          Text(
                            'Selecciona tus productos favoritos',
                            style: AppTextStyles.caption(d),
                          ),
                        ],
                      ),
                    ),
                    if (totalItems > 0)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, CartScreen.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: d.spacingM,
                            vertical: d.spacingS,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(d.borderRadiusL),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: colorScheme.onPrimary,
                                size: d.iconSizeM,
                              ),
                              SizedBox(width: d.spacingS),
                              Text(
                                totalItems.toString(),
                                style: AppTextStyles.button(d).copyWith(
                                  fontSize: d.fontSizeBody,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
                // LinearTimer
                LinearTimer(timer: timer),
                if (isActionLoading)
                  Positioned.fill(
                    child: AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.25),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ),
      ),
    );
  }

  Future<void> handleTimer(BuildContext context, WidgetRef ref, int timer) async {
    if (timer == 0) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(timerProvider.notifier).start(ref.read(secondaryDurationProvider));
          Navigator.pushNamed(context, TimeUpScreen.routeName);
        });
      }
    }
  }


}
