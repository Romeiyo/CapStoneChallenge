import 'package:flutter/material.dart';
import 'package:geo_weather_logger_app/data/location_service.dart';
import 'package:geo_weather_logger_app/data/weather_repository.dart';
import 'package:geo_weather_logger_app/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository;
  final LocationService _locationService;

  Weather? _currentWeather;
  bool _isLoading = false;
  String? _errorMessage;
  String _locationName = 'Unkknown Location';

  Weather? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasData => _currentWeather != null;
  String get locationName => _locationName;

  WeatherProvider(this._repository, this._locationService);

  Future<void> loadWeather(double latitude, double longitude) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _currentWeather = await _repository.fetchCurrentWeather(
        latitude,
        longitude,
      );
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _currentWeather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLocalWeather() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final position = await _locationService.getCurrentPosition();

      _currentWeather = await _repository.fetchCurrentWeather(
        position.latitude,
        position.longitude,
      );

      _locationName =
          'Your Location '
          '(${position.latitude.toStringAsFixed(2)}, '
          '${position.longitude.toStringAsFixed(2)})';
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _currentWeather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
