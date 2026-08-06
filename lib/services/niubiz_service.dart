import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ventas_kiosko/utils/custom_exception.dart';

class NiubizService {
  Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ipPinpad') ?? '';
  }

  // Payment process
  Future<dynamic> paymentProcess(double amount) async {
    final baseUrl = await getBaseUrl();
    print('baseUrl: $baseUrl');

    final url = Uri.parse('$baseUrl/pcl/sale');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      print(responseData);

      return responseData;
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  Future<dynamic> mockPaymentProcess(double amount, String type) async {
    final bodySuccess = jsonEncode({
      "date": "2025-01-24",
      "time": "13:31",
      "authNumber": "250153",
      "batchNumber": "000011",
      "transactionBrand": "MASTERCARD",
      "voucherNumber": "000020",
      "transactionId": "951250240566331",
      "transactionBin": "523510",
      "maskedPAN": "5235100000008893",
      "transactionType": "07",
      "voucherMerchant":
          "                NIUBIZ                \n          VENTA - MASTERCARD          \n         ID: 951250240566331          \nCOMPAIA PERUANA DE MEDIOS - 650009671 \n             LIMA - PERU              \n           ************8893           \nTER: 04222535    LOTE: 011   REF: 0020\nAP: 250153  FECHA:24/01/25  HORA:13:31\n              S/  500.00              \n                                      \nCON EL USO DE MI CLAVE SECRETA        \nAUTORIZO ESTA TRANSACCION             \nRETENGA ESTA COPIA PARA VERIFICAR     \nEN SU ESTADO DE CUENTA.               \n                                      \nDebit Mastercard                      \nAID:A0000000041010                    \nCT: DB20E80D62E2E504                  \n   CAPTURA: CONTACTLESS - Ver: 42A    \n                                      \n12345678901234567890123456789012345678\n\n\n",
      "voucherClient":
          "         ID: 951250240566331          \n           ************8893           \nTER: 04222535    LOTE: 011   REF: 0020\nAP: 250153  FECHA:24/01/25  HORA:13:31\n              S/  $amount              \n                                      \n   CAPTURA: CONTACTLESS - Ver: 42A    \n                                      \n",
      "cardType": "DEBITO",
      "cardApplication": "Debit Mastercard",
      "signatureRequired": "No",
      "issuingBank": "MASTERCARD",
    });

    final bodyError = jsonEncode({"response": "TRANSACCION FALLIDA", "statusCode": "03"});

    final body = type == 'Success' ? bodySuccess : bodyError;

    await Future.delayed(const Duration(seconds: 5));

    try {
      final response = await Future.value(http.Response(body, 200));

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      if (type == 'Success') {
        final failedTransactionBody = jsonEncode({
          'Empresa': 'UPNW',
          'Accion': 'N',
          'CodigoAlumno': 'Test',
          'CodigoOperacion': '2010',
          'NumeroOperacion': '2025-01-24',
          'FechaOperacion': '2025-01-24', // Get date at the beginning of transaction
          'HoraOperacion': '12:00',
          'Institucion': '51',
          'Puerto': 'Puerto',
          'Ip': 'Ip',
          'Estacion': 'Estacion',
          'FechaTrans': '2025-01-24', // Get date from niubiz
          'NumeroOperacionRecaudo': '1234567890',
          'ImporteDeuda': 100,
          'NumTarjeta': '1234****7890',
          'TipoTarjeta': 'C',
          'ImpAutorizado': 100,
          'ReciboEmitido': 'R003',
          'FechaHoraEmisionRecibo': '2025-01-24', // Get date at the end of transaction
          'MontoRecibo': 100,
          'TipoMoneda': 'PEN',
          'DocumentoCorrelativo': '',
          'MontoPagado': 100,
        });

        final prefs = await SharedPreferences.getInstance();
        String failedRequestsString = prefs.getString('failed_requests') ?? '[]';
        List failedRequests = jsonDecode(failedRequestsString);
        failedRequests.add(failedTransactionBody);
        await prefs.setString('failed_requests', jsonEncode(failedRequests));
      }

      return responseData;
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Duplicate process
  Future<dynamic> duplicateProcess() async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/duplicate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          //
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      return responseData['voucherMerchant'];
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Cancel process
  Future<dynamic> cancelProcess() async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/void');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          //
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      return responseData['voucherMerchant'];
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  ////////// Pinpad configuration //////////

  // Report process
  Future<dynamic> printReport(int type) async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/report');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"reportType": type}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      // Save report type 3 to memory
      if (type == 3) {
        final reportValues = extractReportValues(responseData['report']);

        print('########## paramsPinPad: $reportValues');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('paramsPinPad', jsonEncode(reportValues));
      }

      return responseData['report'];
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Función para extraer valores usando expresiones regulares
  Map<String, dynamic> extractReportValues(String reportText) {
    Map<String, dynamic> reportValues = {};

    // Extraer Nombre del Comercio
    RegExp nombreComercioRegExp = RegExp(r'Nombre del Comercio:\s*\n\s*([^\n]+)');
    Match? nombreComercioMatch = nombreComercioRegExp.firstMatch(reportText);
    if (nombreComercioMatch != null) {
      reportValues['Nombre del Comercio'] = nombreComercioMatch.group(1)!.trim();
    }

    // Extraer Ciudad del Comercio
    RegExp ciudadComercioRegExp = RegExp(r'Ciudad del Comercio:\s*\n\s*([^\n]+)');
    Match? ciudadComercioMatch = ciudadComercioRegExp.firstMatch(reportText);
    if (ciudadComercioMatch != null) {
      reportValues['Ciudad del Comercio'] = ciudadComercioMatch.group(1)!.trim();
    }

    // Extraer Cod Comercio
    RegExp codComercioRegExp = RegExp(r'Cod Comercio\s*:\s*([^\n]+)');
    Match? codComercioMatch = codComercioRegExp.firstMatch(reportText);
    if (codComercioMatch != null) {
      reportValues['Cod Comercio'] = codComercioMatch.group(1)!.trim();
    }

    // Extraer Serie Terminal
    RegExp serieTerminalRegExp = RegExp(r'Serie Terminal\s*:\s*([^\n]+)');
    Match? serieTerminalMatch = serieTerminalRegExp.firstMatch(reportText);
    if (serieTerminalMatch != null) {
      reportValues['Serie Terminal'] = serieTerminalMatch.group(1)!.trim();
    }

    // Extraer TPDU Primario
    RegExp tpduPrimarioRegExp = RegExp(r'TPDU Primario\s*:\s*([^\n]+)');
    Match? tpduPrimarioMatch = tpduPrimarioRegExp.firstMatch(reportText);
    if (tpduPrimarioMatch != null) {
      reportValues['TPDU Primario'] = tpduPrimarioMatch.group(1)!.trim();
    }

    // Extraer TPDU Primario
    RegExp niiRegExp = RegExp(r'NII\s*:\s*([^\n]+)');
    Match? niiMatch = niiRegExp.firstMatch(reportText);
    if (niiMatch != null) {
      reportValues['NII'] = niiMatch.group(1)!.trim();
    }

    return reportValues;
  }

  // List terminals
  Future<dynamic> listTerminals() async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/list');

    try {
      final response = await http.get(url);

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      return responseData[0];
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Echo terminal
  Future<dynamic> echoTerminal() async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/echo');

    try {
      final response = await http.get(url);

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      return responseData;
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Batch process
  Future<dynamic> batchProcess() async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/batch');

    try {
      final response = await http.post(url);

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      return responseData;
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Init terminal
  Future<dynamic> initTerminal() async {
    final baseUrl = await getBaseUrl();

    final url = Uri.parse('$baseUrl/pcl/init');

    try {
      final response = await http.get(url);

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 400 ||
          responseData is Map<String, dynamic> && responseData.containsKey('statusCode')) {
        return CustomException(response, responseData);
      }

      return responseData;
    } catch (e) {
      return Exception('Ocurrió un error al enviar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  // Set paramsPinPad manually
  void setParamsPinPad() async {
    final Map<String, dynamic> reportValues = {
      'Nombre del Comercio': 'NIUBIZ',
      'Ciudad del Comercio': 'LIMA-PERU',
      'Cod Comercio': 650009671,
      'Serie Terminal': '04222535',
      'TPDU Primario': '6000080000',
      'NII': '008',
    };

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('paramsPinPad', jsonEncode(reportValues));
  }
}
