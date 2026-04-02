import 'package:dio/dio.dart';
import 'package:geo_weather_logger_app/models/weather_model.dart';

class WeatherRepository {
  final Dio _dio = Dio();

  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Weather> fetchCurrentWeather(double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current_weather': true,
        },
      );

      final Map<String, dynamic> data = response.data;

      return Weather.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out. Check your internet.');
      } else if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('No internet connection.');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }
}
