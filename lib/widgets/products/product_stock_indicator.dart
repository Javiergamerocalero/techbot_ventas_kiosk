import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import '../../styles/app_styles.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';

/// Widget que muestra el stock disponible de un producto
class ProductStockIndicator extends ConsumerWidget {
  final int productId;
  final int originalStock;
  final bool showLabel;

  const ProductStockIndicator({
    super.key,
    required this.productId,
    required this.originalStock,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final stockMap = ref.watch(productStockMapProvider);
    
    // Usar stock actualizado si existe, sino usar el original
    final currentStock = stockMap[productId] ?? originalStock;
    
    // Determinar color según stock
    Color stockColor;
    IconData stockIcon;
    
    if (currentStock == 0) {
      stockColor = colorScheme.error;
      stockIcon = Icons.remove_circle_outline;
    } else if (currentStock <= 3) {
      stockColor = Colors.orange;
      stockIcon = Icons.warning_outlined;
    } else {
      stockColor = colorScheme.secondary;
      stockIcon = Icons.check_circle_outline;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: d.spacingS,
        vertical: d.spacingXS,
      ),
      decoration: BoxDecoration(
        color: stockColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(d.borderRadiusS),
        border: Border.all(
          color: stockColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            stockIcon,
            size: d.iconSizeS,
            color: stockColor,
          ),
          if (showLabel) ...[
            SizedBox(width: d.spacingXS),
            Text(
              currentStock == 0 
                  ? 'Agotado'
                  : 'Stock: $currentStock',
              style: AppTextStyles.caption(d).copyWith(
                color: stockColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Extension para obtener el stock actual de un producto
extension ProductStockExtension on WidgetRef {
  int getCurrentStock(int productId, int originalStock) {
    final stockMap = read(productStockMapProvider);
    return stockMap[productId] ?? originalStock;
  }
  
  bool isProductOutOfStock(int productId, int originalStock) {
    return getCurrentStock(productId, originalStock) == 0;
  }
}
