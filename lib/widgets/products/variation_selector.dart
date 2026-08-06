import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/products/product_variation.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/products/variation_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class VariationSelector extends ConsumerWidget {
  final Product product;
  final Function(ProductVariation?)? onVariationSelected;

  const VariationSelector({
    super.key,
    required this.product,
    this.onVariationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    
    if (!product.hasVariations || product.variations.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedVariationId = ref.watch(
      selectedVariationProvider.select((map) => map[product.id])
    );

    // Agrupar variaciones por atributo
    final attributeGroups = _groupByAttributes(product.variations);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Para cada tipo de atributo (Talla, Color, etc.)
        ...attributeGroups.entries
            .where((entry) => entry.key != 'HEX Color') // Filtrar HEX Color ya que se parsea del atributo Color
            .map((entry) {
          return _buildAttributeSelector(
            context: context,
            ref: ref,
            d: d,
            colorScheme: colorScheme,
            attributeName: entry.key,
            variations: entry.value,
            selectedVariationId: selectedVariationId,
          );
        }),
        
        // Stock de variación seleccionada
        if (selectedVariationId != null)
          _buildStockIndicator(
            context: context,
            d: d,
            colorScheme: colorScheme,
            variationId: selectedVariationId,
          ),
      ],
    );
  }

  Widget _buildAttributeSelector({
    required BuildContext context,
    required WidgetRef ref,
    required AppDimensions d,
    required ColorScheme colorScheme,
    required String attributeName,
    required List<ProductVariation> variations,
    required int? selectedVariationId,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: d.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiqueta del atributo con badge
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: d.spacingS * 0.8,
                  vertical: d.spacingXS * 0.3,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(d.borderRadiusS),
                ),
                child: Text(
                  attributeName.toUpperCase(),
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: d.fontSizeCaption * 0.8,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: d.spacingS),
          Wrap(
            spacing: d.spacingS,
            runSpacing: d.spacingS,
            children: variations.map((variation) {
              final isSelected = variation.id == selectedVariationId;
              final hasStock = variation.hasStock;
              
              // Si el atributo es Color y tiene HEX, mostrar círculo de color
              if (attributeName.toLowerCase().contains('color') && variation.colorHex != null) {
                return _buildColorChip(
                  context: context,
                  ref: ref,
                  d: d,
                  colorScheme: colorScheme,
                  variation: variation,
                  isSelected: isSelected,
                  hasStock: hasStock,
                );
              }
              
              // Para otros atributos, chips normales
              return _buildAttributeChip(
                context: context,
                ref: ref,
                d: d,
                colorScheme: colorScheme,
                variation: variation,
                attributeName: attributeName,
                isSelected: isSelected,
                hasStock: hasStock,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorChip({
    required BuildContext context,
    required WidgetRef ref,
    required AppDimensions d,
    required ColorScheme colorScheme,
    required ProductVariation variation,
    required bool isSelected,
    required bool hasStock,
  }) {
    final hexColor = variation.colorHex!;
    final colorName = variation.colorName ?? '';
    Color chipColor;
    
    try {
      chipColor = Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      chipColor = colorScheme.surfaceContainerHighest;
    }

    return GestureDetector(
      onTap: hasStock ? () => _selectVariation(ref, variation) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nombre del color encima
          if (colorName.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: d.spacingXS * 0.5),
              child: Text(
                colorName,
                style: AppTextStyles.caption(d).copyWith(
                  color: colorScheme.onSurface,
                  fontSize: d.fontSizeCaption * 0.75,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          // Círculo de color
          Container(
            width: d.iconSizeL,
            height: d.iconSizeL,
            decoration: BoxDecoration(
              color: chipColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? colorScheme.primary : colorScheme.outline,
                width: isSelected ? 2.5 : 1,
              ),
            ),
            child: !hasStock
                ? Icon(
                    Icons.close,
                    color: Colors.white,
                    size: d.iconSizeM,
                  )
                : isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: d.iconSizeM,
                      )
                    : null,
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeChip({
    required BuildContext context,
    required WidgetRef ref,
    required AppDimensions d,
    required ColorScheme colorScheme,
    required ProductVariation variation,
    required String attributeName,
    required bool isSelected,
    required bool hasStock,
  }) {
    final attributeValue = variation.getAttribute(attributeName) ?? '';

    return ChoiceChip(
      label: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: d.spacingS * 0.8,
          vertical: d.spacingXS * 0.5,
        ),
        child: Text(attributeValue),
      ),
      selected: isSelected,
      onSelected: hasStock ? (selected) {
        if (selected) {
          _selectVariation(ref, variation);
        }
      } : null,
      selectedColor: colorScheme.primary.withValues(alpha: 0.15),
      backgroundColor: hasStock 
          ? colorScheme.surfaceContainerHighest 
          : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      labelStyle: AppTextStyles.body(d).copyWith(
        color: !hasStock 
            ? colorScheme.onSurface.withValues(alpha: 0.4)
            : isSelected 
                ? colorScheme.primary 
                : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        fontSize: d.fontSizeBody * 0.9,
      ),
      side: BorderSide(
        color: isSelected ? colorScheme.primary : colorScheme.outline.withValues(alpha: 0.5),
        width: isSelected ? 2 : 1,
      ),
      padding: EdgeInsets.all(d.spacingS),
      elevation: isSelected ? 1 : 0,
      shadowColor: colorScheme.primary.withValues(alpha: 0.3),
    );
  }

  Widget _buildStockIndicator({
    required BuildContext context,
    required AppDimensions d,
    required ColorScheme colorScheme,
    required int variationId,
  }) {
    final variation = product.getVariationById(variationId);
    
    if (variation == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top: d.spacingS),
      padding: d.paddingS,
      decoration: BoxDecoration(
        color: variation.hasStock 
            ? colorScheme.secondary.withValues(alpha: 0.1)
            : colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(d.borderRadiusS),
      ),
      child: Row(
        children: [
          Icon(
            variation.hasStock ? Icons.check_circle : Icons.error,
            color: variation.hasStock ? colorScheme.secondary : colorScheme.error,
            size: d.iconSizeS,
          ),
          SizedBox(width: d.spacingS),
          Text(
            variation.hasStock 
                ? 'Stock disponible: ${variation.availableStock}'
                : 'Sin stock',
            style: AppTextStyles.caption(d).copyWith(
              color: variation.hasStock ? colorScheme.secondary : colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _selectVariation(WidgetRef ref, ProductVariation variation) {
    ref.read(selectedVariationProvider.notifier).selectVariation(
      product.id,
      variation.id,
    );
    
    onVariationSelected?.call(variation);
  }

  Map<String, List<ProductVariation>> _groupByAttributes(List<ProductVariation> variations) {
    final Map<String, List<ProductVariation>> groups = {};
    
    for (final variation in variations) {
      for (final attributeName in variation.attributes.keys) {
        if (!groups.containsKey(attributeName)) {
          groups[attributeName] = [];
        }
        
        // Solo agregar si no existe ya una variación con el mismo valor de atributo
        final attributeValue = variation.getAttribute(attributeName);
        final exists = groups[attributeName]!.any(
          (v) => v.getAttribute(attributeName) == attributeValue
        );
        
        if (!exists) {
          groups[attributeName]!.add(variation);
        }
      }
    }
    
    return groups;
  }
}
