import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/variation_selector.dart';

/// Modal para seleccionar variaciones de productos en un combo
class ComboVariationSelectorModal extends ConsumerStatefulWidget {
  final Combo combo;

  const ComboVariationSelectorModal({
    super.key,
    required this.combo,
  });

  @override
  ConsumerState<ComboVariationSelectorModal> createState() =>
      _ComboVariationSelectorModalState();

  /// Muestra el modal y retorna las selecciones de variaciones
  static Future<Map<int, int>?> show({
    required BuildContext context,
    required Combo combo,
  }) async {
    return showModalBottomSheet<Map<int, int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ComboVariationSelectorModal(combo: combo),
    );
  }
}

class _ComboVariationSelectorModalState
    extends ConsumerState<ComboVariationSelectorModal> {
  // Mapa de productId -> variationId seleccionada
  final Map<int, int> _selectedVariations = {};

  List<Product> get _productsWithVariations {
    return widget.combo.products
        .where((p) => p.hasVariations && p.variations.isNotEmpty)
        .toList();
  }

  bool get _allVariationsSelected {
    for (final product in _productsWithVariations) {
      if (!_selectedVariations.containsKey(product.id)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: d.screenHeight * 0.85,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(d.borderRadiusL * 2),
          topRight: Radius.circular(d.borderRadiusL * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: d.spacingM),
            width: d.screenWidth * 0.15,
            height: 5,
            decoration: BoxDecoration(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          
          // Header mínimo
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: d.spacingL,
              vertical: d.spacingM,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.combo.name,
                    style: AppTextStyles.subtitle(d).copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Lista de productos con variaciones
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: d.spacingL,
                vertical: d.spacingM,
              ),
              itemCount: _productsWithVariations.length,
              separatorBuilder: (context, index) => SizedBox(height: d.spacingL),
              itemBuilder: (context, index) {
                final product = _productsWithVariations[index];
                return _buildProductVariationSection(
                  context: context,
                  d: d,
                  colorScheme: colorScheme,
                  product: product,
                );
              },
            ),
          ),

          // Botón compacto
          Container(
            padding: EdgeInsets.all(d.spacingL),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: d.buttonHeight * 1.1,
                child: ElevatedButton(
                  onPressed: _allVariationsSelected
                      ? () => Navigator.pop(context, _selectedVariations)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    disabledBackgroundColor:
                        colorScheme.onSurface.withValues(alpha: 0.12),
                    disabledForegroundColor:
                        colorScheme.onSurface.withValues(alpha: 0.38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(d.borderRadiusM),
                    ),
                  ),
                  child: Text(
                    _allVariationsSelected
                        ? 'AGREGAR'
                        : 'Completa las opciones',
                    style: AppTextStyles.button(d).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductVariationSection({
    required BuildContext context,
    required AppDimensions d,
    required ColorScheme colorScheme,
    required Product product,
  }) {
    final isSelected = _selectedVariations.containsKey(product.id);

    return Container(
      padding: EdgeInsets.all(d.spacingL),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(d.borderRadiusL),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outline.withValues(alpha: 0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre del producto con badge
          Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: AppTextStyles.subtitle(d).copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: d.spacingS,
                    vertical: d.spacingXS * 0.5,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(d.borderRadiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: colorScheme.onSecondaryContainer,
                        size: d.iconSizeS,
                      ),
                      SizedBox(width: d.spacingXS * 0.5),
                      Text(
                        'Seleccionado',
                        style: AppTextStyles.caption(d).copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: d.fontSizeCaption * 0.85,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: d.spacingM),
          
          // Selector de variaciones
          VariationSelector(
            product: product,
            onVariationSelected: (variation) {
              setState(() {
                if (variation != null) {
                  _selectedVariations[product.id] = variation.id;
                  print('✅ Variación seleccionada para ${product.name}: ${variation.formattedAttributes}');
                } else {
                  _selectedVariations.remove(product.id);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
