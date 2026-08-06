import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/categories/category.dart';

/// Servicio para obtener categorías con subcategorías y productos anidados
class CategoriesProductsService {
  final String baseUrl;
  final int tenantId;

  CategoriesProductsService({required this.baseUrl, required this.tenantId});

  /// Obtiene todas las categorías con sus subcategorías y productos
  Future<List<Category>> fetchCategoriesWithProducts() async {
    final url = Uri.parse('$baseUrl/api/tenants/$tenantId/categories/products');
    print('📂🛍️ CategoriesProductsService: Fetching categories with products for tenant $tenantId from: $url');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> categoriesData = jsonResponse['data'] as List<dynamic>;
      
      return categoriesData
          .map((categoryJson) => Category.fromJson(categoryJson as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Error al cargar categorías: ${response.statusCode}');
    }
  }
}
