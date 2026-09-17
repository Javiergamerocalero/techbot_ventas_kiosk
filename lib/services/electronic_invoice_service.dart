import 'dart:convert';
import 'package:ventas_kiosko/services/app_log.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/cart/cart.dart';
import '../models/combos/combo.dart';
import '../models/products/product.dart';
import '../models/config/invoice_type.dart';
import '../models/invoice/electronic_invoice_request.dart';
import '../models/invoice/electronic_invoice_response.dart';
import '../models/invoice/invoice_item.dart';
import '../config/electronic_invoice_config.dart';

/// Servicio para generar JSON de facturación electrónica
class ElectronicInvoiceService {
  /// Emisor de comprobantes de ESTE cliente, tal como viene en la
  /// licencia (`tech_fact.route` y `tech_fact.token`).
  ///
  /// No hay valores por defecto a propósito. Antes estaban fijos en el
  /// código apuntando al emisor de TECHBOT, así que las boletas de San
  /// Fernando se emitieron con el RUC equivocado sin que nada avisara
  /// (Javier, 2026-09-17). Si la licencia no los trae, la emisión falla
  /// con un mensaje claro: es preferible no emitir a emitir a nombre de
  /// otro contribuyente.
  const ElectronicInvoiceService({
    required this.rutaEmisor,
    required this.tokenEmisor,
  });

  final String? rutaEmisor;
  final String? tokenEmisor;

  bool get emisorConfigurado =>
      (rutaEmisor?.trim().isNotEmpty ?? false) &&
      (tokenEmisor?.trim().isNotEmpty ?? false);

  /// Genera el JSON completo para facturación electrónica
  /// 
  Future<Map<String, dynamic>> generateInvoiceJson({
    required Cart cart,
    required InvoiceData invoiceData,
    required int numeroCorrelativo,
    required String serie,
    String? orderId,
    String? paymentMethodName,
  }) async {
    print('📄 Generando JSON de facturación: ${invoiceData.type.displayName}');

    try {
      _validateInvoiceData(invoiceData);
      
      final tipoComprobante = _mapInvoiceTypeToCode(invoiceData.type);
      final numero = numeroCorrelativo.toString();
      final clienteTipoDocumento = _mapClientDocumentType(invoiceData.type);
      final clienteData = _getClientData(invoiceData);
      
      final invoiceItems = _mapCartToInvoiceItems(cart);
      final totals = _calculateTotals(cart);
      
      print('🔄 Formateando fecha...');
      final fechaEmision = _formatDate(DateTime.now());
      print('✅ Fecha: $fechaEmision');
      
      final request = ElectronicInvoiceRequest(
        tipoDeComprobante: tipoComprobante,
        serie: serie,
        numero: numero,
        clienteTipoDeDocumento: clienteTipoDocumento,
        clienteNumeroDeDocumento: clienteData['numero']!,
        clienteDenominacion: clienteData['denominacion']!,
        clienteDireccion: clienteData['direccion']!,
        fechaDeEmision: fechaEmision,
        totalGravada: totals['totalGravada']!,
        totalIgv: totals['totalIgv']!,
        total: totals['total']!,
        descuentoGlobal: totals['descuentoGlobal']!,
        totalDescuento: totals['totalDescuento']!,
        items: invoiceItems,
        observaciones: _generateObservaciones(cart, invoiceData),
        // Nuevos campos requeridos
        ordenCompraServicio: orderId ?? '',
        medioDePago: paymentMethodName ?? '',
        condicionesDePago: 'Contado',
      );
      
      if (!request.isValid) {
        final errors = request.validationErrors;
        print('❌ Errores de validación:');
        for (final error in errors) {
          print('   - $error');
        }
        throw ElectronicInvoiceException(
          'Request inválido: ${errors.join(", ")}',
        );
      }
      
      
      print('🔄 Convirtiendo a JSON...');
      final json = request.toApiJson();
      
      print('✅ JSON generado exitosamente');
      print('📊 Total gravada: ${totals['totalGravada']}');
      print('📊 Total IGV: ${totals['totalIgv']}');
      print('📊 Total: ${totals['total']}');
      print('=' * 80);
      
      return json;
    } catch (e) {
      print('❌ Error generando JSON: $e');
      rethrow;
    }
  }
  
  /// Valida que los datos de facturación sean correctos según el tipo
  void _validateInvoiceData(InvoiceData invoiceData) {
    switch (invoiceData.type) {
      case InvoiceType.simpleBoleta:
        // Boleta simple no requiere validación adicional
        print('✓ Boleta simple - Sin validaciones adicionales');
        break;
        
      case InvoiceType.boletaWithDNI:
        if (invoiceData.dni.isEmpty || invoiceData.dni.length != 8) {
          throw ElectronicInvoiceException('DNI inválido para boleta con DNI');
        }
        if (invoiceData.dniFullName.isEmpty) {
          throw ElectronicInvoiceException('Nombre completo requerido para boleta con DNI');
        }
        if (!invoiceData.isValidated) {
          throw ElectronicInvoiceException('DNI debe estar validado con RENIEC');
        }
        print('✓ Boleta con DNI validada - DNI: ${invoiceData.dni}');
        break;
        
      case InvoiceType.facturaElectronica:
        if (invoiceData.ruc.isEmpty || invoiceData.ruc.length != 11) {
          throw ElectronicInvoiceException('RUC inválido para factura electrónica');
        }
        if (invoiceData.razonSocial.isEmpty) {
          throw ElectronicInvoiceException('Razón social requerida para factura electrónica');
        }
        if (invoiceData.direccion.isEmpty) {
          throw ElectronicInvoiceException('Dirección requerida para factura electrónica');
        }
        if (!invoiceData.isValidated) {
          throw ElectronicInvoiceException('RUC debe estar validado con SUNAT');
        }
        print('✓ Factura electrónica validada - RUC: ${invoiceData.ruc}');
        break;
    }
  }

  /// Mapea el tipo de comprobante de la app al código del API
  int _mapInvoiceTypeToCode(InvoiceType type) {
    switch (type) {
      case InvoiceType.simpleBoleta:
      case InvoiceType.boletaWithDNI:
        return ElectronicInvoiceConfig.tipoBoleta;
      case InvoiceType.facturaElectronica:
        return ElectronicInvoiceConfig.tipoFactura;
    }
  }
  
  /// Mapea el tipo de documento del cliente
  String _mapClientDocumentType(InvoiceType type) {
    switch (type) {
      case InvoiceType.simpleBoleta:
        return ElectronicInvoiceConfig.tipoDocumentoVarios;
      case InvoiceType.boletaWithDNI:
        return ElectronicInvoiceConfig.tipoDocumentoDni;
      case InvoiceType.facturaElectronica:
        return ElectronicInvoiceConfig.tipoDocumentoRuc;
    }
  }
  
  /// Obtiene los datos del cliente según el tipo de comprobante
  Map<String, String> _getClientData(InvoiceData invoiceData) {
    switch (invoiceData.type) {
      case InvoiceType.simpleBoleta:
        print('👤 Cliente: ${ElectronicInvoiceConfig.clienteGenericoDenominacion}');
        return {
          'numero': ElectronicInvoiceConfig.clienteGenericoNumeroDocumento,
          'denominacion': ElectronicInvoiceConfig.clienteGenericoDenominacion,
          'direccion': ElectronicInvoiceConfig.clienteGenericoDireccion,
        };
        
      case InvoiceType.boletaWithDNI:
        print('👤 Cliente: ${invoiceData.dniFullName} (DNI: ${invoiceData.dni})');
        return {
          'numero': invoiceData.dni,
          'denominacion': invoiceData.dniFullName,
          'direccion': ElectronicInvoiceConfig.clienteGenericoDireccion,
        };
        
      case InvoiceType.facturaElectronica:
        print('🏢 Empresa: ${invoiceData.razonSocial} (RUC: ${invoiceData.ruc})');
        print('📍 Dirección: ${invoiceData.direccion}');
        return {
          'numero': invoiceData.ruc,
          'denominacion': invoiceData.razonSocial,
          'direccion': invoiceData.direccion,
        };
    }
  }
  
  /// Convierte todos los items del carrito (productos y combos) a items de factura
  List<InvoiceItem> _mapCartToInvoiceItems(Cart cart) {
    final List<InvoiceItem> invoiceItems = [];
    
    // Agregar productos
    for (final cartItem in cart.items) {
      final product = cartItem.product;
      final quantity = cartItem.quantity;
      
      // Precio unitario con IGV (precio final con descuento aplicado)
      final precioUnitario = product.finalPrice;
      
      // Descuento por item (si aplica) - SIN IGV para InvoiceItem.fromCartItem()
      final descuentoItem = product.hasDiscount 
          ? (product.priceAsDouble - product.finalPrice) * quantity / 1.18
          : 0.0;
      
      invoiceItems.add(InvoiceItem.fromCartItem(
        productId: product.id,
        productName: product.name,
        quantity: quantity,
        unitPrice: precioUnitario,
        discount: descuentoItem,
        isProduct: true,
      ));
    }
    
    // Agregar combos
    for (final comboItem in cart.comboItems) {
      final combo = comboItem.combo;
      final quantity = comboItem.quantity;
      
      // Precio unitario con IGV (precio final con descuento aplicado)
      final double precioUnitario = combo.hasDiscount ? combo.discountedPriceAsDouble : combo.priceAsDouble;
      
      // Descuento por item (si aplica) - SIN IGV para InvoiceItem.fromCartItem()
      final descuentoItem = combo.hasDiscount 
          ? (combo.priceAsDouble - combo.discountedPriceAsDouble) * quantity / 1.18
          : 0.0;
      
      invoiceItems.add(InvoiceItem.fromCartItem(
        productId: combo.id,
        productName: combo.name,
        quantity: quantity,
        unitPrice: precioUnitario,
        discount: descuentoItem,
        isProduct: false, // Es un combo, no un producto
      ));
    }
    
    print('📦 Items mapeados: ${invoiceItems.length} (${cart.items.length} productos + ${cart.comboItems.length} combos)');
    return invoiceItems;
  }
  
  /// Calcula los totales del comprobante
  Map<String, String> _calculateTotals(Cart cart) {
    // Subtotal sin IGV y IGV total (calculados línea por línea para consistencia)
    double totalGravada = 0.0;
    double totalIgv = 0.0;
    
    // Calcular totales línea por línea - PRODUCTOS
    for (final item in cart.items) {
      final product = item.product;
      final quantity = item.quantity;
      
      // Precio unitario con IGV (precio final con descuento aplicado)
      final precioUnitario = product.finalPrice;
      
      // Descuento por item (si aplica) - DEBE CALCULARSE SOBRE PRECIO SIN IGV
      final descuentoItem = product.hasDiscount 
          ? (product.priceAsDouble - product.finalPrice) * quantity / 1.18
          : 0.0;
      
      // Cálculos iguales a InvoiceItem.fromCartItem()
      final valorUnitario = precioUnitario / 1.18; // Precio sin IGV
      final subtotalSinDescuento = valorUnitario * quantity;
      final subtotal = subtotalSinDescuento - descuentoItem;
      final igvItem = subtotal * ElectronicInvoiceConfig.tasaIgv;
      
      totalGravada += subtotal;
      totalIgv += igvItem;
    }
    
    // Calcular totales línea por línea - COMBOS
    for (final comboItem in cart.comboItems) {
      final combo = comboItem.combo;
      final quantity = comboItem.quantity;
      
      // Precio unitario con IGV (precio final con descuento aplicado)
      final double precioUnitario = combo.hasDiscount ? combo.discountedPriceAsDouble : combo.priceAsDouble;
      
      // Descuento por item (si aplica) - DEBE CALCULARSE SOBRE PRECIO SIN IGV
      final descuentoItem = combo.hasDiscount 
          ? (combo.priceAsDouble - combo.discountedPriceAsDouble) * quantity / 1.18
          : 0.0;
      
      // Cálculos iguales a InvoiceItem.fromCartItem()
      final valorUnitario = precioUnitario / 1.18; // Precio sin IGV
      final subtotalSinDescuento = valorUnitario * quantity;
      final subtotal = subtotalSinDescuento - descuentoItem;
      final igvItem = subtotal * ElectronicInvoiceConfig.tasaIgv;
      
      totalGravada += subtotal;
      totalIgv += igvItem;
    }
    
    // Descuento global (del cupón)
    final descuentoGlobal = cart.couponDiscount;
    
    // Ajustar totales si hay descuento global
    if (descuentoGlobal > 0) {
      final descuentoSinIgv = descuentoGlobal / 1.18;
      totalGravada -= descuentoSinIgv;
      totalIgv -= descuentoSinIgv * ElectronicInvoiceConfig.tasaIgv;
    }
    
    // Total final
    final total = totalGravada + totalIgv;
    
    print('🔢 Cálculo de totales:');
    print('   📊 Total Gravada: ${totalGravada.toStringAsFixed(2)}');
    print('   📊 Total IGV: ${totalIgv.toStringAsFixed(2)}');
    print('   📊 Total Final: ${total.toStringAsFixed(2)}');
    print('   💰 Descuento Global: ${descuentoGlobal.toStringAsFixed(2)}');
    
    return {
      'totalGravada': totalGravada.toStringAsFixed(2),
      'totalIgv': totalIgv.toStringAsFixed(2),
      'total': total.toStringAsFixed(2),
      'descuentoGlobal': descuentoGlobal > 0 
          ? descuentoGlobal.toStringAsFixed(2) 
          : '',
      'totalDescuento': descuentoGlobal > 0 
          ? descuentoGlobal.toStringAsFixed(2) 
          : '',
    };
  }
  
  /// Formatea una fecha al formato DD-MM-AAAA
  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
  
  /// Genera observaciones para el comprobante
  String _generateObservaciones(Cart cart, InvoiceData invoiceData) {
    final observaciones = <String>[];
    
    // Agregar información del tipo de comprobante
    observaciones.add('Comprobante generado desde Kiosko de Ventas');
    
    // Agregar información del cupón si aplica
    if (cart.appliedCoupon != null) {
      final coupon = cart.appliedCoupon!;
      observaciones.add('Cupón aplicado: ${coupon.code}');
      
      // Mostrar descuento según el tipo
      if (coupon.type == 'percentage') {
        observaciones.add('Descuento: ${coupon.value}%');
      } else {
        observaciones.add('Descuento: S/ ${coupon.value}');
      }
    }
    
    // Agregar cantidad de items
    observaciones.add('Total de items: ${cart.items.length}');
    
    return observaciones.join('\n');
  }
  
  /// Envía el JSON al API de facturación electrónica
  Future<ElectronicInvoiceResponse> sendToApi(Map<String, dynamic> invoiceJson) async {
    if (!emisorConfigurado) {
      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'emitir comprobante',
        ok: false,
        detalle: 'la licencia no trae el emisor de comprobantes '
            '(tech_fact.route / tech_fact.token)',
      );
      throw ElectronicInvoiceException(
        'Esta licencia no tiene configurado el emisor de comprobantes. '
        'Cargar la ruta y el token en Qapp antes de facturar.',
      );
    }

    print('\n📤 Enviando comprobante al API de facturación electrónica...');
    print('🌐 URL: $rutaEmisor');
    
    try {
      final headers = {
        'Authorization': 'Token $tokenEmisor',
        'Content-Type': 'application/json',
      };
      
      print('🔑 Token configurado');
      print('📦 Enviando ${invoiceJson['items'].length} items');
      
      final reloj = Stopwatch()..start();
      final response = await http.post(
        Uri.parse(rutaEmisor!),
        headers: headers,
        body: jsonEncode(invoiceJson),
      ).timeout(
        Duration(seconds: ElectronicInvoiceConfig.requestTimeout),
        onTimeout: () {
          throw ElectronicInvoiceException(
            'Timeout: El servidor no respondió en ${ElectronicInvoiceConfig.requestTimeout} segundos',
          );
        },
      );
      
      print('📡 Status Code: ${response.statusCode}');

      // Queda registrado para la pantalla de logs (pedido de Javier el
      // 2026-09-16). El token va en los headers, que no se registran.
      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'emitir comprobante',
        request: invoiceJson,
        response: response.body,
        ok: response.statusCode == 200 || response.statusCode == 201,
        detalle: 'HTTP ${response.statusCode} · $rutaEmisor',
        duracion: reloj.elapsed,
      );
      
      // Verificar respuesta exitosa
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('📦 Response body: ${response.body}');
        
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        print('📋 Response data keys: ${responseData.keys.toList()}');
        
        // Verificar si hay errores en la respuesta
        if (responseData.containsKey('errors')) {
          print('❌ API retornó errores: ${responseData['errors']}');
          throw ElectronicInvoiceException(
            'Error del API: ${responseData['errors']}',
            statusCode: response.statusCode,
          );
        }
        
        // Parsear respuesta exitosa
        print('🔄 Intentando parsear respuesta...');
        print('📦 Response completo: ${jsonEncode(responseData)}');
        
        final invoiceResponse = ElectronicInvoiceResponse.fromJson(responseData);
        
        print('✅ Respuesta parseada');
        print('📊 isSuccess: ${invoiceResponse.isSuccess}');
        print('📄 numeroCompleto: ${invoiceResponse.numeroCompleto}');
        print('🔗 enlace: ${invoiceResponse.enlace}');
        print('✓ aceptadaPorSunat: ${invoiceResponse.aceptadaPorSunat}');
        print('📝 sunatDescription: ${invoiceResponse.sunatDescription}');
        print('❌ errorMessage: ${invoiceResponse.errorMessage}');
        
        if (invoiceResponse.isSuccess) {
          print('✅ Comprobante generado exitosamente');
        } else {
          print('⚠️ Comprobante con observaciones');
        }
        
        return invoiceResponse;
      } else {
        // Manejar errores HTTP
        final errorBody = response.body;
        print('❌ Error HTTP ${response.statusCode}');
        print('📋 Response: $errorBody');
        
        throw ElectronicInvoiceException(
          'Error HTTP ${response.statusCode}: $errorBody',
          statusCode: response.statusCode,
        );
      }
    } on ElectronicInvoiceException {
      rethrow;
    } catch (e) {
      print('❌ Error inesperado al enviar al API: $e');
      throw ElectronicInvoiceException(
        'Error de conexión: ${e.toString()}',
      );
    }
  }
}

/// Excepción personalizada para errores de facturación electrónica
class ElectronicInvoiceException implements Exception {
  final String message;
  final int? statusCode;
  
  ElectronicInvoiceException(this.message, {this.statusCode});
  
  @override
  String toString() => 'ElectronicInvoiceException: $message';
}
