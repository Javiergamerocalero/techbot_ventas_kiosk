import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/categories/category.dart';

class CategoryService {
  final String baseUrl;
  final int tenantId;

  CategoryService({required this.baseUrl, required this.tenantId});

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/api/tenants/$tenantId/categories');
    print('📂 CategoryService: Fetching categories for tenant $tenantId from: $url');
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
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar categorías: ${response.statusCode}');
    }
  }
}
