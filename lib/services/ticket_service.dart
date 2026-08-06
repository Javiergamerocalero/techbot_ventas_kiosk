import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/models/cart/cart_item.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/models/config/business_info.dart';
import 'package:intl/intl.dart';

/// Servicio para generar strings de tickets de venta
class TicketService {
  static const String _companyName = "EMPRESA DEMO S.A.C.";
  static const String _companyRuc = "20123456789";
  static const String _companyAddress = "Av. Principal 123, Lima";
  
  /// Genera el string completo del ticket
  static String generateTicketString({
    required Cart cart,
    required Map<String, dynamic> paymentData,
    required String deviceName,
    BusinessInfo? businessInfo,
    int width = 46,
    bool fiscal = true,
  }) {
    String ticket = '';
    final companyName = businessInfo?.businessName.isNotEmpty == true 
        ? businessInfo!.businessName 
        : _companyName;
    final companyAddress = businessInfo?.address.isNotEmpty == true 
        ? businessInfo!.address 
        : _companyAddress;
    final taxId = businessInfo?.taxId.isNotEmpty == true 
        ? businessInfo!.taxId 
        : _companyRuc;
    
    ticket += '${centerTextTruncate(companyName.toUpperCase(), width)}\n';
    ticket += '${centerTextTruncate(companyAddress.toUpperCase(), width)}\n';
    
    if (businessInfo?.branchAddress != null && businessInfo!.branchAddress!.isNotEmpty) {
      if (businessInfo.branchName?.isNotEmpty == true) {
        ticket += '${centerTextTruncate(businessInfo.branchName!.toUpperCase(), width)}\n';
      }
      ticket += '${centerTextTruncate(businessInfo.branchAddress!.toUpperCase(), width)}\n';
    }
    
   // ticket += '-' * width + '\n';
    ticket += '${centerTextTruncate("R.U.C. $taxId", width)}\n';
    if (fiscal) {
      ticket += '${centerTextTruncate("BOLETA DE VENTA ELECTRÓNICA", width)}\n';
      ticket += '${centerTextTruncate("SERIE: B001 CORRELATIVO: 00000123", width)}\n';
    } else {
      ticket += '${centerTextTruncate("NOTA DE VENTA", width)}\n';
    }
    
    final clientDocType = paymentData['clientDocType'] ?? '';
    final clientDocNumber = paymentData['clientDocNumber'] ?? '';
    final clientName = paymentData['clientName'] ?? '';
    
    print('📝 Datos del cliente en ticket:');
    print('   Tipo: $clientDocType');
    print('   Número: $clientDocNumber');
    print('   Nombre: $clientName');
    
    // Solo mostrar datos del cliente si hay documento
    if (clientDocNumber.isNotEmpty) {
      if (clientDocType.toUpperCase() == 'RUC') {
        ticket += '${leftTextTruncate("RUC: $clientDocNumber", width)}\n';
        ticket += '${leftTextTruncate("Razón Social: $clientName", width)}\n';
      } else {
        ticket += '${leftTextTruncate("DNI: $clientDocNumber", width)}\n';
        ticket += '${leftTextTruncate("Nombre: $clientName", width)}\n';
      }
      ticket += '\n';
    }
    
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    ticket += '${leftTextTruncate("Fecha: ${dateFormat.format(now)}", width)}\n';
    String currencySymbol = 'S/';
    if (cart.items.isNotEmpty) {
      currencySymbol = cart.items.first.product.currencySymbol;
    } else if (cart.comboItems.isNotEmpty) {
      currencySymbol = cart.comboItems.first.combo.currencySymbol;
    }
    
    ticket += '${leftTextTruncate("Moneda: $currencySymbol", width)}\n';
    ticket += '\n';
    
    ticket += '-' * width + '\n';
    String header = 'SKU      DESCRIPCION                  TOTAL';
    if (header.length > 46) {
      header = header.substring(0, 46);
    } else if (header.length < 46) {
      header = header.padRight(46);
    }
    ticket += '$header\n';
    ticket += '-' * width + '\n';
    
    for (var cartItem in cart.items) {
      final product = cartItem.product;
      final quantity = cartItem.quantity;
      final unitPrice = product.finalPrice;
      final totalPrice = unitPrice * quantity;
      
      // Usar SKU y nombre efectivos (incluye variación si existe)
      final effectiveSku = cartItem.effectiveSku;
      final effectiveName = cartItem.hasVariation 
          ? '${product.name} (${cartItem.selectedVariation!.formattedAttributes})'
          : product.name;
      
      String productLines = _formatProductLineExact(
        sku: effectiveSku,
        name: effectiveName,
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
        hasDiscount: product.hasDiscount,
        discountAmount: product.discountAmount,
      );
      ticket += '$productLines\n';
    }
    
    for (var comboItem in cart.comboItems) {
      final combo = comboItem.combo;
      final quantity = comboItem.quantity;
      final unitPrice = combo.hasDiscount ? combo.discountedPriceAsDouble : combo.priceAsDouble;
      final totalPrice = unitPrice * quantity;
      String comboLines = _formatProductLineExact(
        sku: combo.sku,
        name: combo.name,
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
        hasDiscount: combo.hasDiscount,
        discountAmount: combo.discountAmount,
      );
      ticket += '$comboLines\n';
    }
    
    ticket += '-' * width + '\n';
    final subtotalSinIGV = cart.totalPrice / 1.18;
    final igvAmount = cart.totalPrice - subtotalSinIGV;
    final totalDiscounts = cart.totalDiscounts + cart.couponDiscount;
    
    ticket += '${spacedText("Operaciones Gravadas:", "$currencySymbol ${subtotalSinIGV.toStringAsFixed(2)}", width)}\n';
    
    if (totalDiscounts > 0) {
      ticket += '${spacedText("Total Descuentos:", "$currencySymbol ${totalDiscounts.toStringAsFixed(2)}", width)}\n';
    }
    
    if (cart.hasCoupon) {
      ticket += '${spacedText("Cupón (${cart.appliedCoupon!.code}):", "$currencySymbol ${cart.couponDiscount.toStringAsFixed(2)}", width)}\n';
    }
    
    ticket += '${spacedText("Subtotal:", "$currencySymbol ${subtotalSinIGV.toStringAsFixed(2)}", width)}\n';
    ticket += '${spacedText("IGV (18%):", "$currencySymbol ${igvAmount.toStringAsFixed(2)}", width)}\n';
    ticket += '${spacedText("TOTAL A PAGAR:", "$currencySymbol ${cart.finalPrice.toStringAsFixed(2)}", width)}\n';
    ticket += '\n';
    final cardBrand = paymentData['cardBrand'] ?? paymentData['transactionBrand'] ?? 'Tarjeta';
    final maskedPAN = paymentData['maskedPAN'] ?? '****0000';
    final authNumber = paymentData['authNumber'] ?? paymentData['auth_number'] ?? '';
    
    ticket += '${spacedText("Método de Pago:", "$cardBrand $maskedPAN", width)}\n';
    ticket += '${spacedText("Monto Recibido:", "$currencySymbol ${cart.finalPrice.toStringAsFixed(2)}", width)}\n';
    ticket += '${spacedText("Vuelto:", "$currencySymbol 0.00", width)}\n';
    
    if (authNumber.isNotEmpty) {
      ticket += '${spacedText("Auth:", authNumber, width)}\n';
    }
    
    ticket += '-' * width + '\n';
    final totalInWords = _numberToWords(cart.finalPrice);
    ticket += '${leftTextTruncate("SON: $totalInWords", width)}\n';
    ticket += '-' * width + '\n';
    ticket += '\n';
    
    ticket += '${centerTextTruncate("Representación impresa del", width)}\n';
    ticket += '${centerTextTruncate("comprobante electrónico", width)}\n';
    ticket += '-' * width + '\n';
    ticket += '\n';
    ticket += '${centerTextTruncate("[QR CODE]", width)}\n';
    ticket += '\n';
    
    return ticket;
  }
  
  /// Centra el texto en el ancho especificado
  static String centerTextTruncate(String text, int width) {
    if (text.length > width) {
      text = text.substring(0, width);
    }
    int spaces = (width - text.length) ~/ 2;
    return '${' ' * spaces}$text${' ' * spaces}${' ' * ((width - text.length) % 2)}';
  }
  
  /// Alinea el texto a la izquierda
  static String leftTextTruncate(String text, int width) {
    if (text.length > width) {
      return text.substring(0, width);
    } else {
      return text.padRight(width);
    }
  }
  
  /// Distribuye dos textos con espacios entre ellos
  static String spacedText(String text1, String text2, int width) {
    int spaces = width - text1.length - text2.length;
    if (spaces > 0) {
      return '$text1${' ' * spaces}$text2';
    } else {
      return '$text1 $text2';
    }
  }
  
  /// Formatea tres columnas 
  static String threeColumnsTruncate(String col1, String col2, String col3, int width1, int width2, int width3) {
    // Limpiar COMPLETAMENTE cualquier carácter problemático
    col1 = col1.replaceAll(RegExp(r'[\n\r\t\f\v]'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
    col2 = col2.replaceAll(RegExp(r'[\n\r\t\f\v]'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
    col3 = col3.replaceAll(RegExp(r'[\n\r\t\f\v]'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
    
    // TRUNCADO ULTRA AGRESIVO - Cortar exactamente en el límite
    String finalCol1 = col1.length > width1 ? col1.substring(0, width1) : col1;
    String finalCol2 = col2.length > width2 ? col2.substring(0, width2) : col2;
    String finalCol3 = col3.length > width3 ? col3.substring(0, width3) : col3;
    
    // Padding exacto para mantener estructura de 46 caracteres
    finalCol1 = finalCol1.padRight(width1, ' ');
    finalCol2 = finalCol2.padRight(width2, ' ');
    finalCol3 = finalCol3.padLeft(width3, ' ');
    
    // Construir resultado y FORZAR longitud exacta
    String result = '$finalCol1$finalCol2$finalCol3';
    int totalWidth = width1 + width2 + width3;
    
    // Si por alguna razón excede, truncar brutalmente
    if (result.length != totalWidth) {
      if (result.length > totalWidth) {
        result = result.substring(0, totalWidth);
      } else {
        result = result.padRight(totalWidth, ' ');
      }
    }
    
    // Verificación de seguridad: eliminar cualquier salto de línea que pueda quedar
    result = result.replaceAll(RegExp(r'[\n\r]'), ' ');
    
    return result;
  }
  
  /// Formatea tres columnas permitiendo que la columna 2 se divida en múltiples líneas
  static String threeColumnsMultiRows(String col1, String col2, String col3, int width1, int width2, int width3) {
    // Preparar primera y tercera columna
    String formattedCol1 = col1.length > width1 ? col1.substring(0, width1) : col1.padRight(width1);
    String formattedCol3 = col3.length > width3 ? col3.substring(0, width3) : col3.padLeft(width3);
    
    // Dividir col2 en chunks de width2
    List<String> descriptionLines = [];
    if (col2.isEmpty) {
      descriptionLines.add('');
    } else {
      for (int i = 0; i < col2.length; i += width2) {
        int end = i + width2 > col2.length ? col2.length : i + width2;
        descriptionLines.add(col2.substring(i, end).padRight(width2));
      }
    }
    
    // Construir resultado: primera línea incluye col1 y col3, siguientes solo col2
    List<String> result = [];
    for (int i = 0; i < descriptionLines.length; i++) {
      if (i == 0) {
        // Primera línea incluye las tres columnas
        result.add('$formattedCol1${descriptionLines[i]}$formattedCol3');
      } else {
        // Líneas siguientes solo incluyen la descripción
        result.add('${''.padRight(width1)}${descriptionLines[i]}${''.padLeft(width3)}');
      }
    }
    
    return result.join('\n');
  }
  
  /// Formatea el SKU a 8 caracteres (------- si está vacío)
  static String _formatSku(String? sku) {
    if (sku == null || sku.isEmpty) {
      return '-------';
    }
    return sku.length > 8 ? sku.substring(0, 8) : sku.padRight(8);
  }
  
  /// Formatea línea de producto completa (principal + detalles)
  static String _formatProductLineExact({
    required String? sku,
    required String name,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    required bool hasDiscount,
    required double discountAmount,
  }) {
    List<String> lines = [];
    bool shouldShowTotal = quantity == 1 && !hasDiscount;
    String mainLine = _formatMainProductLine(sku, name, quantity, totalPrice, showTotal: shouldShowTotal);
    lines.add(mainLine);
    if (hasDiscount) {
      double priceWithoutDiscount = unitPrice + discountAmount;
      double totalWithoutDiscount = priceWithoutDiscount * quantity;
      double totalDiscount = discountAmount * quantity;
      double totalWithDiscount = totalPrice;
      String detailLine = _formatDetailLineWithDiscount(quantity, unitPrice, totalWithoutDiscount, totalDiscount, totalWithDiscount);
      lines.add(detailLine);
    } else if (quantity > 1) {
      String detailLine = _formatDetailLine(quantity, unitPrice, totalPrice, 'V');
      lines.add(detailLine);
    }
    
    return lines.join('\n');
  }
  
  /// Formatea línea principal: SKU + descripción + precio + V
  static String _formatMainProductLine(String? sku, String name, int quantity, double totalPrice, {bool showTotal = true}) {
    // SKU fijo a 8 caracteres
    String skuPart = _formatSku(sku);
    String priceStr = totalPrice.toStringAsFixed(2);
    if (name.isEmpty) name = "Producto";
    
    int maxDescLength = 25;
    
    // Truncar descripción
    String desc = name.length > maxDescLength 
        ? name.substring(0, maxDescLength) 
        : name;
    
    String line = '$skuPart $desc';
    if (!showTotal) {
      return line;
    }
    
    line = line.padRight(36);
    String priceAligned = priceStr.padLeft(6);
    line += '$priceAligned V';
    
    return line;
  }
  
  /// Formatea línea de detalle: cantidad + precio unitario + total + V/D
  static String _formatDetailLine(int quantity, double unitPrice, double totalPrice, String type) {
    String line = '           ';
    String qtyText = '${quantity}UNx';
    line += qtyText;
    line += '  ';
    String unitText = unitPrice.toStringAsFixed(2);
    line += unitText;
    
    line = line.padRight(36);
    String totalStr = totalPrice.toStringAsFixed(2);
    String totalAligned = totalStr.padLeft(6);
    line += '$totalAligned $type';
    
    return line;
  }
  
  /// Formatea línea de detalle con descuento: cantidad + precio + cálculo + total D
  static String _formatDetailLineWithDiscount(int quantity, double unitPrice, double totalBefore, double discount, double totalAfter) {
    String line = '           ';
    String qtyText = '${quantity}UNx';
    line += qtyText;
    line += '  ';
    String unitText = unitPrice.toStringAsFixed(2);
    line += unitText;
    line += '  ';
    String beforeStr = totalBefore.toStringAsFixed(2);
    String discountStr = discount.toStringAsFixed(2);
    line += '$beforeStr - $discountStr';
    
    line = line.padRight(36);
    String afterStr = totalAfter.toStringAsFixed(2);
    String totalAligned = afterStr.padLeft(6);
    line += '$totalAligned D';
    
    return line;
  }
  
  /// Convierte un número a palabras
  static String _numberToWords(double amount) {
    final integerPart = amount.floor();
    final decimalPart = ((amount - integerPart) * 100).round();
    if (integerPart == 0) {
      return "CERO CON $decimalPart/100 SOLES";
    } else if (integerPart == 1) {
      return "UNO CON $decimalPart/100 SOLES";
    } else if (integerPart < 30) {
      final units = [
        "", "UNO", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE",
        "DIEZ", "ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE", "DIECISÉIS", "DIECISIETE",
        "DIECIOCHO", "DIECINUEVE", "VEINTE", "VEINTIUNO", "VEINTIDÓS", "VEINTITRÉS",
        "VEINTICUATRO", "VEINTICINCO", "VEINTISÉIS", "VEINTISIETE", "VEINTIOCHO", "VEINTINUEVE"
      ];
      return "${units[integerPart]} CON $decimalPart/100 SOLES";
    } else {
      return "${integerPart.toString().toUpperCase()} CON $decimalPart/100 SOLES";
    }
  }
}
