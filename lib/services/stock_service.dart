import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/models/products/stock_response.dart';
import 'package:ventas_kiosko/models/config/license_data.dart';

/// Servicio para validar stock de productos y combos.
class StockService {
  final String baseUrl;

  StockService({required this.baseUrl});

  /// Obtiene el ID de la licencia activa 
  Future<int> _getLicenseId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('licenseData');
      
      print('🔍 StockService: JSON de licencia obtenido: ${jsonString != null ? "SÍ" : "NO"}');
      
      if (jsonString != null) {
        print('🔍 StockService: JSON completo de licencia: $jsonString');
        final jsonMap = jsonDecode(jsonString);
        print('🔍 StockService: JSON decodificado: $jsonMap');
        
        final licenseData = LicenseData.fromJson(jsonMap);
        print('🔍 StockService: LicenseData creado - id: ${licenseData.id}, tenantId: ${licenseData.tenantId}');
        
        if (licenseData.id > 0) {
          print('✅ StockService: Usando license ID: ${licenseData.id} (tenant_id: ${licenseData.tenantId})');
          return licenseData.id;
        } else {
          print('⚠️ StockService: License ID inválido (${licenseData.id}), esperado > 0');
        }
      } else {
        print('⚠️ StockService: No hay datos de licencia en SharedPreferences');
      }
      
      print('⚠️ StockService: No se encontró license ID válido en licencia, usando fallback: 1');
      return 1; // Fallback por compatibilidad
    } catch (e) {
      print('❌ StockService: Error obteniendo license ID: $e, usando fallback: 1');
      return 1; // Fallback en caso de error
    }
  }

  /// Valida el stock disponible para un producto específico.
  /// 
  /// Llama al endpoint: POST /api/cart/manage
  /// Body: { "license_id": [id_from_license], "product_id": productId, "quantity": quantity, "variation_id": variationId? }
  /// 
  Future<StockResponse> checkProductStock(
    int productId, 
    int quantity, {
    int? variationId,
  }) async {
    print('🛒 StockService: Iniciando checkProductStock - Producto: $productId, Cantidad: $quantity, Variación: ${variationId ?? "ninguna"}');
    
    try {
      final url = Uri.parse('$baseUrl/api/cart/manage');
      print('🌐 StockService: URL del endpoint: $url');
      
      final licenseId = await _getLicenseId();
      print('🏢 StockService: License ID obtenido: $licenseId');
      
      final requestBody = {
        "license_id": licenseId,
        "product_id": productId,
        "quantity": quantity,
        if (variationId != null) "variation_id": variationId,
      };
      
      print('📤 StockService: Request body completo: ${json.encode(requestBody)}');
      
    
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      );
      
      print('📥 StockService: Response status: ${response.statusCode}');
      print('📥 StockService: Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('✅ StockService: Producto ID $productId - Respuesta exitosa');
        print('✅ StockService: Data recibida: ${json.encode(responseData)}');
        
        final stockReserved = responseData['stock_reserved'] ?? 0;
        final stockAvailable = responseData['stock_available'] ?? 0;
        final message = responseData['message'] ?? 'Producto agregado al carrito exitosamente';
        
        print('✅ StockService: Stock reservado: $stockReserved, Stock disponible: $stockAvailable');
        
        return StockResponse(
          isAvailable: true,
          availableStock: stockAvailable,
          message: message,
          additionalData: {
            'stock_reserved': stockReserved,
            'stock_available': stockAvailable,
            'product_id': productId,
          },
        );
        
      } else if (response.statusCode == 422) {
        final errorData = json.decode(response.body);
        print('❌ StockService: Error 422 - Stock insuficiente');
        print('❌ StockService: Error details: ${json.encode(errorData)}');
        
        return StockResponse(
          isAvailable: false,
          availableStock: 0,
          message: 'Stock insuficiente para este producto',
        );
        
      } else {
        
        return StockResponse(
          isAvailable: false,
          availableStock: 0,
          message: 'Error al verificar disponibilidad (${response.statusCode})',
        );
      }
      
    } catch (e) {
      
      return const StockResponse(
        isAvailable: false,
        availableStock: 0,
        message: 'Error de conexión al validar stock',
      );
    }
  }
  
  /// Elimina un producto del carrito
  /// 
  /// Llama al endpoint: POST /api/cart/manage
  /// Body: { "license_id": [id_from_license], "product_id": productId, "quantity": 0, "variation_id": variationId? }
  /// 
  Future<StockResponse> removeProductFromCart(int productId, {int? variationId}) async {
    print('🗑️ StockService: Eliminando producto ID: $productId del carrito${variationId != null ? ' (variación: $variationId)' : ''}');
    
    try {
      final url = Uri.parse('$baseUrl/api/cart/manage');
      final licenseId = await _getLicenseId();
      
      final requestBody = {
        "license_id": licenseId,
        "product_id": productId,
        "quantity": 0,
        if (variationId != null) "variation_id": variationId,
      };
      
      print('📤 StockService: Body: ${json.encode(requestBody)}');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      );
      
      print('📥 StockService: Response status: ${response.statusCode}');
      print('📥 StockService: Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('✅ StockService: Producto ID $productId eliminado exitosamente');
        print('✅ StockService: Data recibida: ${json.encode(responseData)}');
        
        final stockAvailable = responseData['stock_available'] ?? 0;
        final message = responseData['message'] ?? 'Producto eliminado del carrito exitosamente';
        
        print('✅ StockService: Stock disponible después de eliminar: $stockAvailable');
        
        return StockResponse(
          isAvailable: true,
          availableStock: stockAvailable,
          message: message,
          additionalData: {
            'stock_available': stockAvailable,
            'product_id': productId,
            'action': 'removed',
          },
        );
        
      } else {
        final errorData = json.decode(response.body);
        print('❌ StockService: Error ${response.statusCode} eliminando producto');
        
        return StockResponse(
          isAvailable: false,
          availableStock: 0,
          message: errorData['message'] ?? 'Error al eliminar producto del carrito',
        );
      }
      
    } catch (e) {
      
      return const StockResponse(
        isAvailable: false,
        availableStock: 0,
        message: 'Error de conexión al eliminar producto',
      );
    }
  }

  /// Limpia el carrito completo y repone el stock en el backend
  /// 
  /// Llama al endpoint: POST /api/cart/clear
  /// Body: { "license_id": [id_from_license] }
  /// 
  Future<StockResponse> clearCart() async {
    print('🧹 StockService: Limpiando carrito completo y reponiendo stock');
    
    try {
      final url = Uri.parse('$baseUrl/api/cart/clear');
      final licenseId = await _getLicenseId();
      
      final requestBody = {
        "license_id": licenseId,
      };
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      );
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        print('✅ StockService: Carrito limpiado exitosamente');
        print('✅ StockService: ${responseData['message']}');
        
        // Extraer la lista de productos con stock actualizado desde stock_adjustments
        final stockAdjustments = responseData['stock_adjustments'] as List<dynamic>?;
        final stockUpdates = <int, int>{};
        
        if (stockAdjustments != null) {
          for (final adjustmentData in stockAdjustments) {
            final productId = adjustmentData['product_id'] as int;
            final stockAvailable = adjustmentData['stock_available'] as int;
            stockUpdates[productId] = stockAvailable;
            print('📦 StockService: Producto ID $productId - Stock liberado: $stockAvailable');
          }
        }
        
        return StockResponse(
          isAvailable: true,
          availableStock: 0, 
          message: responseData['message'] ?? 'Carrito limpiado y stock repuesto exitosamente',
          additionalData: {
            'stock_updates': stockUpdates, // Mapa de productId -> stock_available
          },
        );
      } else {
        print('❌ StockService: Error al limpiar carrito - Status: ${response.statusCode}');
        print('❌ StockService: Response: ${response.body}');
        
        return StockResponse(
          isAvailable: false,
          availableStock: 0,
          message: 'Error al limpiar carrito (${response.statusCode})',
        );
      }
      
    } catch (e) {
      
      return const StockResponse(
        isAvailable: false,
        availableStock: 0,
        message: 'Error de conexión al limpiar carrito',
      );
    }
  }

  /// Actualiza la cantidad de un combo en el carrito y ajusta el stock.
  /// 
  /// Llama al endpoint: POST /api/cart/combo
  /// Body: { "license_id": [id_from_license], "combo_id": comboId, "quantity": quantity }
  /// 
  Future<StockResponse> updateComboCart(int comboId, int quantity) async {
    print('🍽️ StockService: Actualizando combo en carrito - ID: $comboId, Cantidad: $quantity');
    
    try {
      final url = Uri.parse('$baseUrl/api/cart/combo');
      print('🍽️ StockService: URL: $url');
      final licenseId = await _getLicenseId();
      
      final requestBody = {
        "license_id": licenseId,
        "combo_id": comboId,
        "quantity": quantity,
      };
      print('🍽️ StockService: Request body: ${json.encode(requestBody)}');
      
      print('🍽️ StockService: Enviando petición HTTP...');
      
      // Crear un timer para monitorear el progreso
      Timer.periodic(const Duration(seconds: 1), (timer) {
        print('⏱️ StockService: Esperando respuesta... ${timer.tick}s');
        if (timer.tick >= 5) {
          timer.cancel();
        }
      });
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      ).timeout(
        const Duration(seconds: 5), // Timeout más agresivo
        onTimeout: () {
          print('❌ StockService: Timeout - El servidor no respondió en 5 segundos');
          throw Exception('Timeout: El servidor no respondió en 5 segundos');
        },
      );
     
      print('🔍 StockService: Verificando si statusCode == 200...');
      if (response.statusCode == 200) {
        print('✅ StockService: Procesando respuesta exitosa...');
        try {
          print('🔍 StockService: Iniciando parsing JSON...');
          final decodedJson = json.decode(response.body);
          print('🔍 StockService: JSON decodificado: $decodedJson');
          print('🔍 StockService: Tipo del JSON: ${decodedJson.runtimeType}');
          final responseData = decodedJson as Map<String, dynamic>;
          print('✅ StockService: JSON parseado correctamente');
          print('✅ StockService: Combo actualizado exitosamente');
          print('✅ StockService: ${responseData['message']}');
        
        // Extraer información del combo actualizado
        final comboId = responseData['combo_id'] as int?;
        final comboQuantity = responseData['quantity'] as int?;
        
        // Extraer la lista de ajustes de stock de productos afectados
        final stockAdjustments = responseData['stock_adjustments'] as List<dynamic>?;
        final stockUpdates = <int, int>{};
        
        if (stockAdjustments != null) {
          for (final adjustmentData in stockAdjustments) {
            final productId = adjustmentData['product_id'] as int;
            final stockAvailable = adjustmentData['stock_available'] as int;
            stockUpdates[productId] = stockAvailable;
            print('📦 StockService: Producto ID $productId - Stock ajustado: $stockAvailable');
          }
        }
        
        return StockResponse(
          isAvailable: true,
          availableStock: comboQuantity ?? 0,
          message: responseData['message'] ?? 'Combo actualizado exitosamente',
          additionalData: {
            'combo_id': comboId,
            'combo_quantity': comboQuantity,
            'stock_updates': stockUpdates, // Mapa de productId -> stock_available
          },
        );
        } catch (e) {
          print('❌ StockService: Error al procesar respuesta exitosa: $e');
          return StockResponse(
            isAvailable: false,
            availableStock: 0,
            message: 'Error al procesar respuesta del servidor',
          );
        }
      } else {
        print('❌ StockService: StatusCode no es 200 - Valor: ${response.statusCode}');
        print('❌ StockService: Error al actualizar combo - Status: ${response.statusCode}');
        print('❌ StockService: Response: ${response.body}');
        
        return StockResponse(
          isAvailable: false,
          availableStock: 0,
          message: 'Error al actualizar combo (${response.statusCode})',
        );
      }
      
    } catch (e) {
      print('❌ StockService: Error de conexión al actualizar combo: $e');
      
      return const StockResponse(
        isAvailable: false,
        availableStock: 0,
        message: 'Error de conexión al actualizar combo',
      );
    }
  }

  /// Actualiza la cantidad de un combo con variaciones seleccionadas en el carrito.
  /// 
  /// Llama al endpoint: POST /api/cart/combo
  /// Body: { "license_id": [id], "combo_id": comboId, "quantity": quantity, "variations": {productId: variationId} }
  /// 
  Future<StockResponse> updateComboCartWithVariations(
    int comboId,
    int quantity,
    Map<int, int> selectedVariations,
  ) async {
    print('🍽️ StockService: Actualizando combo con variaciones - ID: $comboId, Cantidad: $quantity');
    print('📋 StockService: Variaciones: $selectedVariations');
    
    try {
      final url = Uri.parse('$baseUrl/api/cart/combo');
      final licenseId = await _getLicenseId();
      
      // Convertir Map<int, int> a array de objetos para el backend
      // Formato esperado: [{"product_id": 5, "variation_id": 4}]
      final variationsArray = selectedVariations.entries.map((entry) => {
        "product_id": entry.key,
        "variation_id": entry.value,
      }).toList();
      
      final requestBody = {
        "license_id": licenseId,
        "combo_id": comboId,
        "quantity": quantity,
        "variation_selections": variationsArray,
      };
      print('🍽️ StockService: Request body: ${json.encode(requestBody)}');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Timeout: El servidor no respondió');
        },
      );
     
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final responseData = decodedJson as Map<String, dynamic>;
        print('✅ StockService: Combo con variaciones actualizado exitosamente');
        
        final comboQuantity = responseData['quantity'] as int?;
        final stockAdjustments = responseData['stock_adjustments'] as List<dynamic>?;
        final stockUpdates = <int, int>{};
        
        if (stockAdjustments != null) {
          for (final adjustmentData in stockAdjustments) {
            final productId = adjustmentData['product_id'] as int;
            final stockAvailable = adjustmentData['stock_available'] as int;
            stockUpdates[productId] = stockAvailable;
            print('📦 StockService: Producto ID $productId - Stock ajustado: $stockAvailable');
          }
        }
        
        return StockResponse(
          isAvailable: true,
          availableStock: comboQuantity ?? 0,
          message: responseData['message'] ?? 'Combo con variaciones agregado',
          additionalData: {
            'combo_id': comboId,
            'combo_quantity': comboQuantity,
            'stock_updates': stockUpdates,
          },
        );
      } else {
        print('❌ StockService: Error ${response.statusCode}: ${response.body}');
        
        return StockResponse(
          isAvailable: false,
          availableStock: 0,
          message: 'Error al actualizar combo (${response.statusCode})',
        );
      }
      
    } catch (e) {
      print('❌ StockService: Error al actualizar combo con variaciones: $e');
      
      return const StockResponse(
        isAvailable: false,
        availableStock: 0,
        message: 'Error de conexión',
      );
    }
  }
}
