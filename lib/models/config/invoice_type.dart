import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_type.freezed.dart';
part 'invoice_type.g.dart';

/// Tipos de facturación disponibles
enum InvoiceType {
  @JsonValue('simple_boleta')
  simpleBoleta,
  
  @JsonValue('boleta_with_dni')
  boletaWithDNI,
  
  @JsonValue('factura_electronica')
  facturaElectronica,
}

/// Extensión para obtener información de cada tipo
extension InvoiceTypeExtension on InvoiceType {
  String get displayName {
    switch (this) {
      case InvoiceType.simpleBoleta:
        return 'Boleta simple';
      case InvoiceType.boletaWithDNI:
        return 'Boleta electrónica';
      case InvoiceType.facturaElectronica:
        return 'Factura electrónica';
    }
  }

  String get description {
    switch (this) {
      case InvoiceType.simpleBoleta:
        return 'No requiere datos';
      case InvoiceType.boletaWithDNI:
        return 'Requiere DNI';
      case InvoiceType.facturaElectronica:
        return 'Requiere RUC';
    }
  }

  String get iconName {
    switch (this) {
      case InvoiceType.simpleBoleta:
        return 'receipt';
      case InvoiceType.boletaWithDNI:
        return 'badge';
      case InvoiceType.facturaElectronica:
        return 'business';
    }
  }

  bool get requiresInput {
    return this != InvoiceType.simpleBoleta;
  }
  
  bool get requiresValidation {
    return this == InvoiceType.boletaWithDNI || this == InvoiceType.facturaElectronica;
  }
}

/// Modelo de datos de facturación
@freezed
sealed class InvoiceData with _$InvoiceData {
  const factory InvoiceData({
    required InvoiceType type,
    @Default('') String dni,
    @Default('') String dniFullName,
    @Default('') String ruc,
    @Default('') String razonSocial,
    @Default('') String direccion,
    @Default(false) bool isValidated,
  }) = _InvoiceData;

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);
}

/// Extensión para validación de InvoiceData
extension InvoiceDataValidation on InvoiceData {
  bool get isValid {
    switch (type) {
      case InvoiceType.simpleBoleta:
        return true;
        
      case InvoiceType.boletaWithDNI:
        return dni.length == 8 && isValidated;
               
      case InvoiceType.facturaElectronica:
        return ruc.length == 11 && isValidated;
    }
  }

  String? get validationError {
    switch (type) {
      case InvoiceType.simpleBoleta:
        return null;
        
      case InvoiceType.boletaWithDNI:
        if (dni.isEmpty) return 'Ingrese el DNI';
        if (dni.length != 8) return 'DNI debe tener 8 dígitos';
        if (!isValidated) return 'DNI no validado';
        return null;
               
      case InvoiceType.facturaElectronica:
        if (ruc.isEmpty) return 'Ingrese el RUC';
        if (ruc.length != 11) return 'RUC debe tener 11 dígitos';
        if (!isValidated) return 'RUC no validado';
        return null;
    }
  }
}
