import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/products/product_variation.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/products/variation_selector.dart';

/// Modal para seleccionar variaciones de un producto individual
class ProductVariationSelectorModal extends ConsumerStatefulWidget {
  final Product product;

  const ProductVariationSelectorModal({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductVariationSelectorModal> createState() =>
      _ProductVariationSelectorModalState();

  /// Muestra el modal y retorna la variación seleccionada
  static Future<ProductVariation?> show({
    required BuildContext context,
    required Product product,
  }) async {
    return showModalBottomSheet<ProductVariation>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => ProductVariationSelectorModal(product: product),
    );
  }
}

class _ProductVariationSelectorModalState
    extends ConsumerState<ProductVariationSelectorModal> {
  ProductVariation? _selectedVariation;

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: d.screenHeight * 0.9,
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
                    widget.product.name,
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

          // Contenido scrolleable con más espacio
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: d.spacingL,
                vertical: d.spacingM,
              ),
              child: VariationSelector(
                product: widget.product,
                onVariationSelected: (variation) {
                  setState(() {
                    _selectedVariation = variation;
                  });
                  print('✅ Variación seleccionada: ${variation?.formattedAttributes ?? "ninguna"}');
                },
              ),
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
                  onPressed: _selectedVariation != null
                      ? () => Navigator.pop(context, _selectedVariation)
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
                    _selectedVariation != null
                        ? 'AGREGAR'
                        : 'Selecciona una opción',
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
}
