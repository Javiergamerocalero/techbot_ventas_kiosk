import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/products/stock_response.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/combos/combo_provider.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';
import 'package:ventas_kiosko/screens/cart_screen.dart';
import 'package:ventas_kiosko/screens/combo_detail_screen.dart';
import 'package:ventas_kiosko/screens/product_detail_screen.dart';
import 'package:ventas_kiosko/utils/product_catalog.dart';
import 'package:ventas_kiosko/utils/debug_session_log.dart';

/// Resuelve un SKU escaneado en pantallas pre-pago.
///
/// Busca en todo el catálogo (incluye SKUs sin `PUB-`). Si el producto
/// exige variación, abre el detalle; si no, lo agrega y va al carrito.
class BarcodeScanHandler {
  BarcodeScanHandler._();

  static Future<void> handle(
    BuildContext context,
    WidgetRef ref,
    String code,
  ) async {
    final cleaned = code.trim();
    if (cleaned.isEmpty) return;

    List<Product> products = const [];
    try {
      products = await ref.read(allProductsProvider.future);
    } catch (_) {
      products = const [];
    }

    final product = ProductCatalog.findProductBySku(products, cleaned);
    if (product != null) {
      await _handleProduct(context, ref, product);
      return;
    }

    try {
      final combos = await ref.read(allCombosProvider.future);
      final combo = ProductCatalog.findComboBySku(combos, cleaned);
      if (!context.mounted) return;
      if (combo != null) {
        Navigator.of(context).pushNamed(
          ComboDetailScreen.routeName,
          arguments: combo,
        );
        return;
      }
    } catch (_) {}

    if (!context.mounted) return;
    _showSnack(context, 'Producto no encontrado: $cleaned', Colors.red);
  }

  static Future<void> _handleProduct(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) async {
    if (product.isOutOfStock) {
      _showSnack(context, 'Sin stock: ${product.name}', Colors.red);
      return;
    }
    if (product.hasVariations && product.requiresVariationSelection) {
      Navigator.of(context).pushNamed(
        ProductDetailScreen.routeName,
        arguments: product,
      );
      return;
    }

    final response = await ref
        .read(cartNotifierProvider.notifier)
        .validateAndAddProduct(product, quantity: 1);
    if (!context.mounted) return;
    if (!response.isAvailable) {
      _showSnack(
        context,
        response.getDisplayMessage(product.name),
        Colors.red,
      );
      return;
    }
    _showSnack(context, 'Agregado: ${product.name}', Colors.green);
    // #region agent log
    agentDebugLog(
      location: 'barcode_scan_handler.dart:_handleProduct',
      message: 'Barcode added product and navigating to cart',
      hypothesisId: 'E',
      data: {'sku': product.sku, 'name': product.name, 'published': ProductCatalog.isPublishedSku(product.sku)},
    );
    // #endregion
    final current = ModalRoute.of(context)?.settings.name;
    if (current != CartScreen.routeName) {
      Navigator.of(context).pushNamed(CartScreen.routeName);
    }
  }

  static void _showSnack(BuildContext context, String message, Color color) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
