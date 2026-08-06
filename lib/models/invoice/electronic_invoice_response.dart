import 'package:freezed_annotation/freezed_annotation.dart';

part 'electronic_invoice_response.freezed.dart';
part 'electronic_invoice_response.g.dart';

/// Modelo de respuesta del API de facturación electrónica
@freezed
sealed class ElectronicInvoiceResponse with _$ElectronicInvoiceResponse {
  const ElectronicInvoiceResponse._();

  const factory ElectronicInvoiceResponse({
    /// Tipo de comprobante generado
    @JsonKey(name: 'tipo_de_comprobante') required int tipoDeComprobante,
    
    /// Serie del comprobante
    required String serie,
    
    /// Número del comprobante
    required int numero,
    
    /// Enlace al comprobante en la plataforma
    @Default('') String enlace,
    
    /// Enlace al PDF del comprobante
    @JsonKey(name: 'enlace_del_pdf') @Default('') String enlaceDelPdf,
    
    /// Enlace al XML del comprobante
    @JsonKey(name: 'enlace_del_xml') @Default('') String enlaceDelXml,
    
    /// Enlace al CDR (Constancia de Recepción)
    @JsonKey(name: 'enlace_del_cdr') @Default('') String enlaceDelCdr,
    
    /// Indica si fue aceptada por SUNAT
    @JsonKey(name: 'aceptada_por_sunat') required bool aceptadaPorSunat,
    
    /// Descripción de SUNAT
    @JsonKey(name: 'sunat_description') @Default('') String sunatDescription,
    
    /// Nota de SUNAT (puede ser null)
    @JsonKey(name: 'sunat_note') String? sunatNote,
    
    /// Código de respuesta de SUNAT
    @JsonKey(name: 'sunat_responsecode') @Default('') String sunatResponsecode,
    
    /// Error SOAP de SUNAT (vacío si no hay error)
    @JsonKey(name: 'sunat_soap_error') @Default('') String sunatSoapError,
    
    /// Cadena para generar código QR
    @JsonKey(name: 'cadena_para_codigo_qr') @Default('') String cadenaParaCodigoQr,
    
    /// Hash del comprobante
    @JsonKey(name: 'codigo_hash') @Default('') String codigoHash,
  }) = _ElectronicInvoiceResponse;

  factory ElectronicInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ElectronicInvoiceResponseFromJson(json);

  /// Verifica si la respuesta fue exitosa
  bool get isSuccess => aceptadaPorSunat && sunatResponsecode == '0';

  /// Obtiene el número completo del comprobante (serie-numero)
  String get numeroCompleto => '$serie-$numero';

  /// Verifica si hay errores
  bool get hasErrors => !aceptadaPorSunat || sunatSoapError.isNotEmpty;

  /// Obtiene el mensaje de error si existe
  String? get errorMessage {
    if (sunatSoapError.isNotEmpty) return sunatSoapError;
    if (!aceptadaPorSunat) return sunatDescription;
    return null;
  }
}
