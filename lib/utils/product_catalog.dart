import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/products/product.dart';

/// Catálogo público del kiosco: solo se listan SKUs con prefijo `PUB`
/// (mismo criterio que DeliBakery). El resto sigue resolviéndose por
/// escaneo de barras.
class ProductCatalog {
  ProductCatalog._();

  static bool isPublishedSku(String sku) {
    final s = sku.trim();
    if (s.isEmpty) return false;
    return s.toUpperCase().startsWith('PUB');
  }

  static List<Product> publishedOnly(List<Product> products) =>
      products.where((p) => isPublishedSku(p.sku)).toList();

  static List<Combo> publishedCombos(List<Combo> combos) =>
      combos.where((c) => isPublishedSku(c.sku)).toList();

  /// Busca por SKU de producto o de variación (case-insensitive).
  static Product? findProductBySku(List<Product> products, String code) {
    final needle = code.trim().toUpperCase();
    if (needle.isEmpty) return null;
    for (final product in products) {
      if (product.sku.toUpperCase() == needle) return product;
      for (final variation in product.variations) {
        final sku = variation.sku;
        if (sku != null && sku.toUpperCase() == needle) return product;
      }
    }
    return null;
  }

  static Combo? findComboBySku(List<Combo> combos, String code) {
    final needle = code.trim().toUpperCase();
    if (needle.isEmpty) return null;
    for (final combo in combos) {
      if (combo.sku.toUpperCase() == needle) return combo;
    }
    return null;
  }
}
