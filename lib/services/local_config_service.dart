import 'package:shared_preferences/shared_preferences.dart';
import '../models/config/app_config.dart';

class LocalConfigService {
  static const String _configKey = 'app_config';

  Future<void> saveConfig(AppConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_configKey, config.toJsonString());
  }

  Future<AppConfig?> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_configKey);
    if (jsonStr == null) return null;
    return AppConfigJson.fromJsonString(jsonStr);
  }

  Future<void> clearConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_configKey);
  }
}
