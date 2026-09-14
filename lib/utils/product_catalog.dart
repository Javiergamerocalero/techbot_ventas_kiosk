import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/products/product.dart';

/// Catálogo público del kiosco: solo se listan SKUs con prefijo `PUB`
/// (mismo criterio que DeliBakery). El resto sigue resolviéndose por
/// escaneo de barras.
class ProductCatalog {
  ProductCatalog._();

  static const kPrefShowAllSkus = 'catalog_show_all_skus';

  /// Cuando está activo el listado ignora el prefijo y muestra todo el
  /// catálogo del tenant. Es la salida para operar mientras el cliente
  /// termina de marcar sus SKUs en Qapp: sin esto, un tenant sin ningún
  /// `PUB` queda con el menú vacío. Se controla desde Config → Catálogo
  /// y arranca apagado.
  static bool showAllSkus = false;

  /// Lee la preferencia guardada. Se llama una vez al arrancar la app,
  /// antes del primer build, porque el filtro se consulta en código
  /// síncrono.
  static Future<void> loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    showAllSkus = prefs.getBool(kPrefShowAllSkus) ?? false;
  }

  static Future<void> setShowAllSkus(bool value) async {
    showAllSkus = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kPrefShowAllSkus, value);
  }

  static bool isPublishedSku(String sku) {
    if (showAllSkus) return true;
    final s = sku.trim();
    if (s.isEmpty) return false;
    return s.toUpperCase().startsWith('PUB');
  }

  static List<Product> publishedOnly(List<Product> products) =>
      products.where((p) => isPublishedSku(p.sku)).toList();

  /// Busca por SKU de producto o de variación (case-insensitive).
  /// Ignora el filtro de publicación a propósito: el escáner tiene que
  /// encontrar justamente los productos que no se listan.
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
