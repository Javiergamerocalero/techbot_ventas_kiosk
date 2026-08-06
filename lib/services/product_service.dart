import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/products/product.dart';

class ProductService {
  final String baseUrl;
  final int tenantId;

  ProductService({required this.baseUrl, required this.tenantId});

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$baseUrl/api/tenants/$tenantId/products');
    print('🛍️ ProductService: Fetching products for tenant $tenantId from: $url');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['data'];
      final products = data.map((item) => Product.fromJson(item)).toList();
      
      // Logging de variaciones
      int productsWithVariations = 0;
      int totalVariations = 0;
      for (final product in products) {
        if (product.hasVariations) {
          productsWithVariations++;
          totalVariations += product.variations.length;
          print('📦 Producto "${product.name}": ${product.variations.length} variaciones');
        }
      }
      
      print('✅ ProductService: ${products.length} productos cargados');
      if (productsWithVariations > 0) {
        print('🔀 ProductService: $productsWithVariations productos con variaciones ($totalVariations variaciones totales)');
      }
      
      return products;
    } else {
      throw Exception('Error al cargar productos: ${response.statusCode}');
    }
  }
}
