import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';

/// Servicio para obtener combos desde la API
class ComboService {
  final String baseUrl;
  final int tenantId;

  ComboService({required this.baseUrl, required this.tenantId});

  /// Obtiene todos los combos desde el endpoint /api/tenants/{tenantId}/combos
  Future<List<Combo>> fetchCombos() async {
    try {
      final url = Uri.parse('$baseUrl/api/tenants/$tenantId/combos');
      print('🔗 ComboService: Fetching combos for tenant $tenantId from: $url');
      
      final response = await http.get(
        url,
        headers: {
        'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        },
      );

      print('📡 ComboService: Response status: ${response.statusCode}');
      print('📄 ComboService: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('🔍 ComboService: Parsed JSON response: $jsonResponse');
        
        final List<dynamic> combosJson = jsonResponse['data'] ?? [];
        print('📋 ComboService: Combos data array length: ${combosJson.length}');
        
        if (combosJson.isNotEmpty) {
          print('🎯 ComboService: First combo sample: ${combosJson.first}');
        }
        
        final List<Combo> combos = combosJson
            .map((json) {
              try {
                return Combo.fromCustomJson(json as Map<String, dynamic>);
              } catch (e) {
                print('❌ ComboService: Error parsing combo: $json');
                print('❌ ComboService: Parse error: $e');
                rethrow;
              }
            })
            .toList();
            
        print('✅ ComboService: Successfully parsed ${combos.length} combos');
        return combos;
      } else {
        print('❌ ComboService: HTTP Error ${response.statusCode}: ${response.body}');
        throw Exception('Error al cargar combos: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 ComboService: Exception caught: $e');
      throw Exception('Error de conexión al cargar combos: $e');
    }
  }
}
