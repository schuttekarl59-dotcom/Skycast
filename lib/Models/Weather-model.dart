

class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final String description;
  final String mainCondition;
  final int humidity;
  final double windSpeed;
  final int rainChance;

  // Constructor
  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.rainChance,
  });

  // Convert API JSON data into a WeatherModel object
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      minTemperature: (json['main']['temp_min'] as num).toDouble(),
      maxTemperature: (json['main']['temp_max'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      mainCondition: json['weather'][0]['main'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      rainChance: 0,
    );
  }
}

class HourlyForecastModel {
  final DateTime dateTime;
  final double temperature;
  final String condition;

  HourlyForecastModel({
    required this.dateTime,
    required this.temperature,
    required this.condition,
  });

  factory HourlyForecastModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HourlyForecastModel(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}