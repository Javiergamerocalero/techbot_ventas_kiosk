import 'package:http/http.dart';

class CustomException implements Exception {
  static const statusCodeMap = {
    '02': 'Se venció el tiempo de espera durante la operación.',
    '03': 'La terminal no permite realizar la operación o el usuario cancelo presionando la tecla roja.',
    '05': 'La operación no se puede realizar por que el lote esta vacío.',
    '08': 'Error de comunicación con el HOST.',
    '09': 'Tarjeta no permitida para la operación seleccionada.',
    '0B': 'Error interno durante el procesamiento de la transacción.',
    'FF': 'Error generando un ticket o reporte. Contactar a soporte.',
  };

  final Response response;
  final dynamic responseData;

  CustomException(this.response, this.responseData);

  @override
  String toString() {
    if (response.statusCode >= 400) {
      print(responseData);
      return responseData['message'] ?? responseData;
    } else if (responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
      final statusCode = responseData['statusCode'];
      final description = statusCodeMap[statusCode] ?? 'Error desconocido';
      return description;
    } else {
      return 'Error desconocido';
    }
  }
}
