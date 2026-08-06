/// Configuración para el servicio de facturación electrónica
class ElectronicInvoiceConfig {
  // ==================== CONFIGURACIÓN DEL API ====================
  
  /// URL del endpoint de facturación electrónica
  /// Según documentación: https://demo.nubefact.com/api/v1/{ruc_emisor}
  static const String apiUrl = 'https://api.pse.pe/api/v1/edebb255eccd4896b5a52d866a58ca74f1cad8b59d9d428dafab4890fb4c4045';
  
  /// Token de autorización para el API
  static const String apiToken = 'eyJhbGciOiJIUzI1NiJ9.ImEwZTQ2ZjVjMjUzNTRjNmQ5Y2JhNzUyMjc0ZWQ5NWE3NGIxMTZiMGViYzZmNGRjOGFmY2ZmMzIyMWU2MThiNjIi.ng1Kp_0o4x9qqzqmcIydxgjWkoKUh_S1JKaPKqz9Y8g';
  
  /// Timeout para las peticiones HTTP (en segundos)
  static const int requestTimeout = 30;
  
  // ==================== SERIES DE COMPROBANTES ====================
  
  /// Serie para facturas electrónicas (debe empezar con F)
  static const String facturaSerie = 'F001';
  
  /// Serie para boletas de venta (debe empezar con B)
  static const String boletaSerie = 'B001';
  
  /// Serie para notas de crédito asociadas a facturas
  static const String notaCreditoFacturaSerie = 'FC01';
  
  /// Serie para notas de crédito asociadas a boletas
  static const String notaCreditoBoletaSerie = 'BC01';
  
  // ==================== CONFIGURACIÓN TRIBUTARIA ====================
  
  /// Porcentaje de IGV en Perú
  static const String porcentajeIgv = '18.00';
  
  /// Tasa de IGV como decimal (0.18)
  static const double tasaIgv = 0.18;
  
  // ==================== TIPOS DE COMPROBANTE ====================
  
  /// Código para FACTURA
  static const int tipoFactura = 1;
  
  /// Código para BOLETA
  static const int tipoBoleta = 2;
  
  /// Código para NOTA DE CRÉDITO
  static const int tipoNotaCredito = 3;
  
  /// Código para NOTA DE DÉBITO
  static const int tipoNotaDebito = 4;
  
  // ==================== TIPOS DE DOCUMENTO DE CLIENTE ====================
  
  /// RUC - Registro Único de Contribuyente
  static const String tipoDocumentoRuc = '6';
  
  /// DNI - Documento Nacional de Identidad
  static const String tipoDocumentoDni = '1';
  
  /// VARIOS - Para ventas menores a S/.700.00
  static const String tipoDocumentoVarios = '-';
  
  /// Carnet de Extranjería
  static const String tipoDocumentoCarnetExtranjeria = '4';
  
  /// Pasaporte
  static const String tipoDocumentoPasaporte = '7';
  
  // ==================== TIPOS DE MONEDA ====================
  
  /// Soles peruanos
  static const String monedaSoles = '1';
  
  /// Dólares americanos
  static const String monedaDolares = '2';
  
  /// Euros
  static const String monedaEuros = '3';
  
  // ==================== TIPOS DE TRANSACCIÓN SUNAT ====================
  
  /// Venta interna (el más común)
  static const int transaccionVentaInterna = 1;
  
  /// Exportación
  static const int transaccionExportacion = 2;
  
  /// Venta interna - Anticipos
  static const int transaccionVentaInternaAnticipos = 4;
  
  // ==================== TIPOS DE IGV ====================
  
  /// Gravado - Operación Onerosa
  static const int tipoIgvGravado = 1;
  
  /// Gravado - Retiro por premio
  static const int tipoIgvGravadoRetiroPremio = 2;
  
  /// Exonerado - Operación Onerosa
  static const int tipoIgvExonerado = 8;
  
  /// Inafecto - Operación Onerosa
  static const int tipoIgvInafecto = 9;
  
  /// Exportación
  static const int tipoIgvExportacion = 16;
  
  // ==================== UNIDADES DE MEDIDA ====================
  
  /// NIU - Producto
  static const String unidadMedidaProducto = 'NIU';
  
  /// ZZ - Servicio
  static const String unidadMedidaServicio = 'ZZ';
  
  // ==================== CÓDIGOS SUNAT POR DEFECTO ====================
  
  /// Código genérico para productos
  static const String codigoProductoSunatGenerico = '10000000';
  
  /// Código genérico para servicios
  static const String codigoServicioSunatGenerico = '20000000';
  
  // ==================== CONFIGURACIÓN DE ENVÍO ====================
  
  /// Enviar automáticamente a SUNAT
  static const String enviarAutomaticoSunat = 'true';
  
  /// No enviar automáticamente a SUNAT
  static const String noEnviarAutomaticoSunat = 'false';
  
  /// Enviar automáticamente al cliente
  static const String enviarAutomaticoCliente = 'true';
  
  /// No enviar automáticamente al cliente
  static const String noEnviarAutomaticoCliente = 'false';
  
  // ==================== FORMATOS DE PDF ====================
  
  /// Formato A4
  static const String formatoPdfA4 = 'A4';
  
  /// Formato A5
  static const String formatoPdfA5 = 'A5';
  
  /// Formato TICKET
  static const String formatoPdfTicket = 'TICKET';
  
  // ==================== VALORES BOOLEANOS ====================
  
  /// Valor true en string
  static const String valorTrue = 'true';
  
  /// Valor false en string
  static const String valorFalse = 'false';
  
  // ==================== CONFIGURACIÓN DE CLIENTE GENÉRICO ====================
  
  /// Denominación para cliente genérico (boleta simple)
  static const String clienteGenericoDenominacion = 'CLIENTE VARIOS';
  
  /// Dirección para cliente genérico
  static const String clienteGenericoDireccion = 'LIMA - LIMA - PERÚ';
  
  /// Número de documento para cliente genérico
  static const String clienteGenericoNumeroDocumento = '00000000';
  
  // ==================== HELPERS ====================
  
  /// Obtiene la serie según el tipo de comprobante
  static String getSerieByType(int tipoComprobante) {
    switch (tipoComprobante) {
      case tipoFactura:
        return facturaSerie;
      case tipoBoleta:
        return boletaSerie;
      case tipoNotaCredito:
        return notaCreditoFacturaSerie; // Por defecto, se puede ajustar
      case tipoNotaDebito:
        return notaCreditoFacturaSerie; // Por defecto, se puede ajustar
      default:
        return boletaSerie;
    }
  }
  
  /// Obtiene el nombre del tipo de comprobante
  static String getTipoComprobanteName(int tipo) {
    switch (tipo) {
      case tipoFactura:
        return 'FACTURA';
      case tipoBoleta:
        return 'BOLETA';
      case tipoNotaCredito:
        return 'NOTA DE CRÉDITO';
      case tipoNotaDebito:
        return 'NOTA DE DÉBITO';
      default:
        return 'DESCONOCIDO';
    }
  }
  
  /// Valida que una serie sea correcta según el tipo de comprobante
  static bool isSerieValid(String serie, int tipoComprobante) {
    if (serie.length != 4) return false;
    
    switch (tipoComprobante) {
      case tipoFactura:
        return serie.startsWith('F');
      case tipoBoleta:
        return serie.startsWith('B');
      default:
        return true;
    }
  }
}
