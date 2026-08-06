import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/config/app_config.dart';
import '../../services/local_config_service.dart';

part 'app_config_provider.g.dart';

@Riverpod(keepAlive: true)
class AppConfigNotifier extends AsyncNotifier<AppConfig?> {
  final _localService = LocalConfigService();

@override
Future<AppConfig?> build() async {
    return await _localService.loadConfig();
  }

  Future<void> setConfig(AppConfig config) async {
    await _localService.saveConfig(config);
    state = AsyncValue.data(config);
  }

  Future<void> clearConfig() async {
    await _localService.clearConfig();
    state = const AsyncValue.data(null);
  }
}
