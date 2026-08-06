import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/services/combo_service.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';

part 'combo_provider.g.dart';

String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: 'API_URL not found')
      : dotenv.get('PROD_URL', fallback: 'API_URL not found');
}

/// Provider principal que obtiene todos los combos desde la API
@Riverpod(keepAlive: true)
Future<List<Combo>> allCombos(Ref ref) async {
  final tenantId = ref.read(licenseProvider.notifier).requireTenantId();
  print('🏢 ComboProvider: Using tenant ID: $tenantId');
  
  final service = ComboService(
    baseUrl: _getBaseUrl(),
    tenantId: tenantId,
  );
  return await service.fetchCombos();
}

/// Provider que filtra combos destacados (activos)
@Riverpod(keepAlive: true)
Future<List<Combo>> featuredCombos(Ref ref) async {
  final allCombos = await ref.watch(allCombosProvider.future);
  return allCombos.where((combo) => combo.isActive).toList();
}

/// Provider que obtiene un combo específico por ID
@Riverpod(keepAlive: true)
Future<Combo?> comboById(Ref ref, int comboId) async {
  final allCombos = await ref.watch(allCombosProvider.future);
  try {
    return allCombos.firstWhere((combo) => combo.id == comboId);
  } catch (e) {
    return null;
  }
}
