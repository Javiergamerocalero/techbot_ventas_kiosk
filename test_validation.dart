import 'lib/services/dni_ruc_validation_service.dart';

void main() async {
  // El token se obtiene de la licencia: configuration -> apis_net_pe_key
  const token = 'apis-token-7493.hJ07UfZG4k5UjcOa1pFavTH7SpaGYXeg';

  final service = DniRucValidationService(apisNetPeToken: token);

  print('=== Testing DNI Validation ===');
  await testDni(service, '09825191'); // Test DNI

  print('\n=== Testing RUC Validation ===');
  await testRuc(service, '20601355761'); // Test RUC
}

Future<void> testDni(DniRucValidationService service, String dni) async {
  try {
    print('Validating DNI: $dni');
    final result = await service.validateDni(dni);

    print('✅ DNI is valid!');
    print('Full Name: ${result.fullName}');
    print('Nombres: ${result.nombres}');
    print('Apellido Paterno: ${result.apellidoPaterno}');
    print('Apellido Materno: ${result.apellidoMaterno}');
  } catch (e) {
    if (e is DniValidationException) {
      print('❌ DNI Validation Error: ${e.message}');
      if (e.statusCode != null) {
        print('Status Code: ${e.statusCode}');
      }
    } else {
      print('❌ Unexpected Error: $e');
    }
  }
}

Future<void> testRuc(DniRucValidationService service, String ruc) async {
  try {
    print('Validating RUC: $ruc');
    final result = await service.validateRuc(ruc);

    print('✅ RUC is valid!');
    print('Razón Social: ${result.razonSocial}');
    print('Dirección: ${result.direccion}');
    print('Ubigeo: ${result.ubigeo}');
    if (result.estado != null) print('Estado: ${result.estado}');
    if (result.condicion != null) print('Condición: ${result.condicion}');
  } catch (e) {
    if (e is RucValidationException) {
      print('❌ RUC Validation Error: ${e.message}');
      if (e.statusCode != null) {
        print('Status Code: ${e.statusCode}');
      }
    } else {
      print('❌ Unexpected Error: $e');
    }
  }
}
