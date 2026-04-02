import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _keyIsCelsius = 'isCelsius';
  static const String _keyIsDarkMode = 'isDarkMode';

  Future<void> saveTemperatureUnit(bool isCelsius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsCelsius, isCelsius);
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsDarkMode, isDarkMode);
  }

  Future<Map<String, bool>> loadAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'isCelsius': prefs.getBool(_keyIsCelsius) ?? true,
      'isDarkMode': prefs.getBool(_keyIsDarkMode) ?? false,
    };
  }

  Future<void> clearAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsCelsius);
    await prefs.remove(_keyIsDarkMode);
  }
}
