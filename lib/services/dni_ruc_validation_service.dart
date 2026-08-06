import 'dart:convert';
import 'package:http/http.dart' as http;

const Duration _defaultTimeout = Duration(seconds: 10);

/// Service for validating Peruvian DNI and RUC documents
/// Test with: dart run test_validation.dart
class DniRucValidationService {
  final String apisNetPeToken;

  DniRucValidationService({required this.apisNetPeToken});

  /// Validates a DNI and returns person data
  ///
  /// Returns a [DniValidationResult] with validation status and person data
  ///
  /// Throws [DniValidationException] if validation fails
  Future<DniValidationResult> validateDni(String dni) async {
    final url = Uri.parse('https://api.decolecta.com/v1/reniec/dni?numero=$dni');

    try {
      final response = await http
          .get(url, headers: {'Accept': 'application/json', 'Authorization': 'Bearer $apisNetPeToken'})
          .timeout(
            _defaultTimeout,
            onTimeout: () {
              throw DniValidationException(
                message: 'Tiempo de espera agotado. Por favor, intente de nuevo.',
                statusCode: 408,
              );
            },
          );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        final msg =
            [
              'dni no valido',
              'invalid request',
              'not found',
            ].contains((responseData['message'] as String?)?.toLowerCase())
            ? 'DNI no encontrado'
            : responseData['message'];
        throw DniValidationException(message: msg ?? 'Error al validar DNI', statusCode: response.statusCode);
      }

      final fullName =
          '${responseData['first_name']} '
          '${responseData['first_last_name']} '
          '${responseData['second_last_name']}';

      return DniValidationResult(
        isValid: true,
        dni: dni,
        nombres: responseData['first_name'],
        apellidoPaterno: responseData['first_last_name'],
        apellidoMaterno: responseData['second_last_name'],
        fullName: fullName,
      );
    } catch (error) {
      if (error is DniValidationException) {
        rethrow;
      }
      throw DniValidationException(message: error.toString(), statusCode: null);
    }
  }

  /// Validates a RUC and returns company data
  ///
  /// Returns a [RucValidationResult] with validation status and company data
  ///
  /// Throws [RucValidationException] if validation fails
  Future<RucValidationResult> validateRuc(String ruc) async {
    // First validate RUC checksum
    if (!_validateRucChecksum(ruc)) {
      throw RucValidationException(message: 'RUC no válido', statusCode: null);
    }

    final url = Uri.parse('https://api.decolecta.com/v1/sunat/ruc?numero=$ruc');

    try {
      final response = await http
          .get(url, headers: {'Accept': 'application/json', 'Authorization': 'Bearer $apisNetPeToken'})
          .timeout(
            _defaultTimeout,
            onTimeout: () {
              throw RucValidationException(
                message: 'Tiempo de espera agotado. Por favor, intente de nuevo.',
                statusCode: 408,
              );
            },
          );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        final msg = ['ruc no valido', 'not found'].contains((responseData['message'] as String?)?.toLowerCase())
            ? 'RUC no encontrado'
            : responseData['message'];
        throw RucValidationException(message: msg ?? 'Error validating RUC', statusCode: response.statusCode);
      }

      return RucValidationResult(
        isValid: true,
        ruc: ruc,
        razonSocial: responseData['razon_social'],
        direccion: responseData['direccion'],
        ubigeo: responseData['ubigeo'],
        estado: responseData['estado'],
        condicion: responseData['condicion'],
      );
    } catch (error) {
      if (error is RucValidationException) {
        rethrow;
      }
      throw RucValidationException(message: error.toString(), statusCode: null);
    }
  }

  /// Validates RUC checksum using SUNAT algorithm
  bool _validateRucChecksum(String ruc) {
    if (ruc.length != 11) return false;

    try {
      // Convert the RUC string to a list of integers
      List<int> digits = ruc.split('').map(int.parse).toList();

      // Define the weight values for each digit
      List<int> weights = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2];

      // Calculate the sum of the products of corresponding digits and weights
      int sum = 0;
      for (int i = 0; i < digits.length - 1; i++) {
        sum += digits[i] * weights[i];
      }

      // Calculate the remainder when the sum is divided by 11
      int remainder = sum % 11;

      // Calculate the verification digit
      int verificationDigit = 11 - remainder;

      // If the verification digit is 10 or 11, consider only the last digit
      verificationDigit = verificationDigit >= 10 ? verificationDigit % 10 : verificationDigit;

      return verificationDigit == digits[10];
    } catch (e) {
      return false;
    }
  }
}

/// Result of DNI validation
class DniValidationResult {
  final bool isValid;
  final String dni;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String fullName;

  DniValidationResult({
    required this.isValid,
    required this.dni,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fullName,
  });

  Map<String, dynamic> toJson() => {
    'isValid': isValid,
    'dni': dni,
    'nombres': nombres,
    'apellidoPaterno': apellidoPaterno,
    'apellidoMaterno': apellidoMaterno,
    'fullName': fullName,
  };
}

/// Result of RUC validation
class RucValidationResult {
  final bool isValid;
  final String ruc;
  final String razonSocial;
  final String direccion;
  final String ubigeo;
  final String? estado;
  final String? condicion;

  RucValidationResult({
    required this.isValid,
    required this.ruc,
    required this.razonSocial,
    required this.direccion,
    required this.ubigeo,
    this.estado,
    this.condicion,
  });

  Map<String, dynamic> toJson() => {
    'isValid': isValid,
    'ruc': ruc,
    'razonSocial': razonSocial,
    'direccion': direccion,
    'ubigeo': ubigeo,
    'estado': estado,
    'condicion': condicion,
  };
}

/// Exception thrown when DNI validation fails
class DniValidationException implements Exception {
  final String message;
  final int? statusCode;

  DniValidationException({required this.message, this.statusCode});

  @override
  String toString() => 'DniValidationException: $message';
}

/// Exception thrown when RUC validation fails
class RucValidationException implements Exception {
  final String message;
  final int? statusCode;

  RucValidationException({required this.message, this.statusCode});

  @override
  String toString() => 'RucValidationException: $message';
}
