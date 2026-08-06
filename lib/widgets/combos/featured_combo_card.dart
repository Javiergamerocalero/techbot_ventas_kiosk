import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/products/variation_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';
import 'package:ventas_kiosko/widgets/combos/combo_variation_selector_modal.dart';
import 'package:ventas_kiosko/widgets/images/cached_combo_image.dart';

class FeaturedComboCard extends ConsumerWidget {
  final Combo combo;
  final double? width;

  const FeaturedComboCard({
    super.key,
    required this.combo,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    
    // Obtener combo del carrito
    final cartItem = ref.watch(comboInCartProvider(combo.id.toString()));
    final quantity = cartItem?.quantity ?? 0;
    
    // Verificar si el combo está agotado basado en sus productos
    final isOutOfStock = combo.isOutOfStock;
    
// Eliminado hasDiscount - ya no se usa

    return Stack(
      children: [
        // Card principal
        Container(
          width: width ?? d.screenWidth * 0.42, // Mismo ancho que productos para consistencia
          margin: EdgeInsets.only(right: d.spacingL), // Más separación como en productos
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(d.borderRadiusM),
            boxShadow: [
              BoxShadow(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
                blurRadius: d.spacingS,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: d.screenWidth * 0.28, // Altura reducida para cards más compactos
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo blanco para mejor contraste
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(d.borderRadiusM),
                        topRight: Radius.circular(d.borderRadiusM),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(d.borderRadiusM),
                        topRight: Radius.circular(d.borderRadiusM),
                      ),
                      child: CachedComboImage(
                        combo: combo,
                        height: d.screenWidth * 0.28, // Altura reducida para cards más compactos
                        width: double.infinity,
                        fit: BoxFit.contain, // Mostrar imagen completa sin recortar
                      ),
                    ),
                  ),
                  // Badge de descuento
                  if (combo.hasDiscount && !isOutOfStock)
                    Positioned(
                      top: d.spacingS,
                      left: d.spacingS,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: d.spacingS,
                          vertical: d.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error.withValues(alpha: 0.7), // Mismo estilo que badge sin stock
                          borderRadius: BorderRadius.circular(d.borderRadiusS),
                        ),
                        child: Text(
                          '-${combo.discountPercentage?.toInt()}%',
                          style: AppTextStyles.caption(d).copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                            fontSize: d.fontSizeCaption * 0.9, // Mismo tamaño que badge sin stock
                          ),
                        ),
                      ),
                    ),
                  // Badge de sin stock (prioridad sobre descuento)
                  if (isOutOfStock)
                    Positioned(
                      top: d.spacingS,
                      left: d.spacingS,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: d.spacingS,
                          vertical: d.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error.withValues(alpha: 0.7), // Más ligero con transparencia
                          borderRadius: BorderRadius.circular(d.borderRadiusS),
                        ),
                        child: Text(
                          'Sin Stock',
                          style: AppTextStyles.caption(d).copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                            fontSize: d.fontSizeCaption * 0.9,
                          ),
                        ),
                      ),
                    ),
                  // Badge de cantidad en carrito
                  if (quantity > 0)
                    Positioned(
                      top: d.spacingS,
                      right: d.spacingS,
                      child: Container(
                        width: d.iconSizeM,
                        height: d.iconSizeM,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            quantity.toString(),
                            style: AppTextStyles.caption(d).copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Contenido del combo compacto (igual que productos)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(d.spacingS), // Padding más pequeño
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título compacto
                      Expanded(
                        flex: 2,
                        child: Text(
                          combo.name,
                          style: AppTextStyles.cardTitleSmall(d).copyWith(
                            fontSize: d.fontSizeCaption * 1.15, // Texto más grande para aprovechar el espacio
                            height: 1.2,
                            fontWeight: FontWeight.w600, // Un poco más bold
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: d.spacingXS * 0.5), // Espaciado más pequeño
                      // Fila de precio y botón
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Precio compacto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  combo.formattedPrice,
                                  style: AppTextStyles.priceSmall(d).copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                    fontSize: d.fontSizeCaption * 1.1, // Precio más grande proporcional al título
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // Botón compacto para combos mejorado
                          GestureDetector(
                            onTap: isOutOfStock ? null : () => _handleIncrement(context, ref),
                            child: Container(
                              width: d.iconSizeL, // Tamaño aumentado
                              height: d.iconSizeL,
                              decoration: BoxDecoration(
                                color: isOutOfStock 
                                    ? colorScheme.onSurface.withValues(alpha: 0.3)
                                    : colorScheme.primary,
                                borderRadius: BorderRadius.circular(d.borderRadiusS),
                                boxShadow: isOutOfStock ? null : [
                                  BoxShadow(
                                    color: colorScheme.primary.withValues(alpha: 0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add, // Siempre ícono '+'
                                color: isOutOfStock 
                                    ? colorScheme.onSurface.withValues(alpha: 0.5) // Gris cuando no hay stock
                                    : colorScheme.onPrimary, // Blanco cuando hay stock
                                size: d.iconSizeM,
                              ),
                            ),
                          ),
                        ],
                      ), // Cierre del Row
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // GestureDetector para navegación (cubre toda la card excepto el botón)
        Positioned(
          top: 0,
          left: 0,
          right: d.iconSizeL + d.spacingS, // Excluir solo el ancho del botón
          bottom: d.iconSizeL + d.spacingS, // Excluir solo el alto del botón
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context, 
                '/combo-detail',
                arguments: combo,
              );
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  /// Maneja el incremento de cantidad del combo
  Future<void> _handleIncrement(BuildContext context, WidgetRef ref) async {
    final buttonKey = 'featured_combo_${combo.id}_inc';
    
    // Verificar si ya hay una operación en progreso
    if (ref.read(buttonLoadingProvider.notifier).isLoading(buttonKey)) {
      return;
    }
    
    // Si no hay stock (basado en productos), no hacer nada (sin modal)
    if (combo.isOutOfStock) {
      return;
    }
    
    final cart = ref.read(cartNotifierProvider);
    final existingCombo = cart.comboItems.where((item) => item.combo.id == combo.id).firstOrNull;
    final currentQuantity = existingCombo?.quantity ?? 0;
    
    // Verificar si el combo tiene productos que REQUIEREN selección de variaciones
    final hasProductsRequiringVariations = combo.products.any((p) => 
      p.hasVariations && 
      p.variations.isNotEmpty && 
      p.requiresVariationSelection
    );
    
    if (hasProductsRequiringVariations && currentQuantity == 0) {
      if (!context.mounted) return;
      
      // Limpiar selecciones previas
      for (final product in combo.products) {
        if (product.hasVariations) {
          ref.read(selectedVariationProvider.notifier).clearSelection(product.id);
        }
      }
      
      // Mostrar modal de selección de variaciones
      final selectedVariations = await ComboVariationSelectorModal.show(
        context: context,
        combo: combo,
      );
      
      // Si el usuario canceló, no hacer nada
      if (selectedVariations == null) {
        print('❌ Usuario canceló selección de variaciones para combo ${combo.name}');
        return;
      }
      
      print('✅ Variaciones seleccionadas para combo ${combo.name}: $selectedVariations');
      
      // TEMPORAL: Validación de SKU comentada para probar backend
      // TODO: Descomentar cuando los datos del backend estén actualizados
      /*
      // Validar que las variaciones seleccionadas tengan SKU
      for (final entry in selectedVariations.entries) {
        final productId = entry.key;
        final variationId = entry.value;
        final product = combo.products.firstWhere((p) => p.id == productId);
        final variation = product.variations.firstWhere((v) => v.id == variationId);
        
        if (variation.sku == null) {
          print('⚠️ Variación sin SKU detectada: Producto ${product.name}, Variación ID: ${variation.id}');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: La variación seleccionada de "${product.name}" no tiene SKU asignado. Contacte al administrador.'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
          return;
        }
      }
      */
      
      // Agregar combo con variaciones
      try {
        await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
          final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantityWithVariations(
            combo.id.toString(),
            1,
            selectedVariations,
          );
          
          if (response.isAvailable && existingCombo == null) {
            print('🍽️ FeaturedComboCard: ✅ Combo con variaciones agregado al carrito local');
            ref.read(cartNotifierProvider.notifier).addCombo(combo, quantity: 1);
          }
        });
      } catch (e) {
        if (e.toString().contains('Operation already in progress')) {
          return;
        }
      }
      return;
    }
    
    // Flujo normal sin variaciones
    try {
      await ref.read(buttonLoadingProvider.notifier).executeWithLoading(buttonKey, () async {
        final newQuantity = currentQuantity + 1;
        
        print('🍽️ FeaturedComboCard: Agregando combo ${combo.name} (cantidad: $newQuantity)');
        
        // Llamar al endpoint para validar stock
        final response = await ref.read(cartNotifierProvider.notifier).updateComboQuantity(combo.id.toString(), newQuantity);
        
        // Si el stock está disponible Y el combo no existía antes, agregarlo manualmente
        if (response.isAvailable && existingCombo == null) {
          print('🍽️ FeaturedComboCard: ✅ Stock disponible - agregando combo al carrito local');
          ref.read(cartNotifierProvider.notifier).addCombo(combo, quantity: newQuantity);
        }
        // Si no hay stock disponible, no hacer nada (sin modal)
      });
    } catch (e) {
      // Si la operación ya está en progreso, ignorar silenciosamente
      if (e.toString().contains('Operation already in progress')) {
        return;
      }
      
      // Error de conexión: no mostrar modal, solo ignorar silenciosamente
    }
  }
}
