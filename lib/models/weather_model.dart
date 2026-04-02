class Weather {
  final double temperature;
  final double windspeed;
  final int weatherCode;
  final String condition;
  final String time;
  Weather({
    required this.temperature,
    required this.windspeed,
    required this.weatherCode,
    required this.condition,
    required this.time,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['current_weather'] as Map<String, dynamic>;
    final temp = (currentWeather['temperature'] as num).toDouble();
    final wind = (currentWeather['windspeed'] as num).toDouble();
    final code = currentWeather['weathercode'] as int;
    final timeStr = currentWeather['time'] as String;
    final conditionText = _mapWeatherCode(code);
    return Weather(
      temperature: temp,
      windspeed: wind,
      weatherCode: code,
      condition: conditionText,
      time: timeStr,
    );
  }
  static String _mapWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'Clear';
      case 1:
        return 'Mainly Clear';
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rainy';
      case 71:
      case 73:
      case 75:
        return 'Snowy';
      case 77:
        return 'Snow Grains';
      case 80:
      case 81:
      case 82:
        return 'Rain Showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with Hail';
      default:
        return 'Unknown';
    }
  }
}
