import 'package:flutter/material.dart';
import 'package:geo_weather_logger_app/data/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository;

  bool _isDarkMode = false;
  bool _isCelsius = true;
  bool _isLoaded = false;

  bool get isDarkMode => _isDarkMode;
  bool get isCelsius => _isCelsius;
  bool get isLoaded => _isLoaded;

  SettingsProvider(this._repository) {
    _init();
  }

  Future<void> _init() async {
    final settings = await _repository.loadAllSettings();
    _isCelsius = settings['isCelsius']!;
    _isDarkMode = settings['isDarkMode']!;
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    await _repository.saveThemeMode(value);
  }

  Future<void> toggleTemperatureUnit(bool value) async {
    _isCelsius = value;
    notifyListeners();
    await _repository.saveTemperatureUnit(value);
  }

  Future<void> resetAllSettings() async {
    _isDarkMode = false;
    _isCelsius = true;
    notifyListeners();
    await _repository.clearAllSettings();
  }
}
