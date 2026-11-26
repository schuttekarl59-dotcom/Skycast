import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/Weather-model.dart';

class WeatherService {
  final String apiKey = String.fromEnvironment('API Key here');
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherModel> getWeather(String cityName) async {
    try {
      // 1. Get current weather
      final weatherUrl = Uri.parse(
        '$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric',
      );

      final weatherResponse = await http.get(weatherUrl);

      if (weatherResponse.statusCode != 200) {
        throw Exception('Unable to retrieve current weather');
      }

      final weatherData = jsonDecode(weatherResponse.body);

      // Convert current weather into a model
      final currentWeather = WeatherModel.fromJson(weatherData);

      // 2. Get forecast information
      final forecastUrl = Uri.parse(
        '$baseUrl/forecast?q=$cityName&appid=$apiKey&units=metric',
      );

      final forecastResponse = await http.get(forecastUrl);

      int rainChance = 0;

      if (forecastResponse.statusCode == 200) {
        final forecastData = jsonDecode(forecastResponse.body);

        final forecastList = forecastData['list'];

        if (forecastList != null && forecastList.isNotEmpty) {
          // Check the next 24 hours (8 forecast periods)
          final next24Hours = forecastList.take(8);

          double highestRainChance = 0;

          for (final forecast in next24Hours) {
            final pop = (forecast['pop'] as num?)?.toDouble() ?? 0;

            print('Forecast time: ${forecast['dt_txt']}');
            print('Rain probability: ${(pop * 100).round()}%');

            if (pop > highestRainChance) {
              highestRainChance = pop;
            }
          }

          rainChance = (highestRainChance * 100).round();

          print('Highest rain probability: $rainChance%');
        }
      }

      // 3. Return weather with rain probability
      return WeatherModel(
        cityName: currentWeather.cityName,
        temperature: currentWeather.temperature,
        feelsLike: currentWeather.feelsLike,
        minTemperature: currentWeather.minTemperature,
        maxTemperature: currentWeather.maxTemperature,
        description: currentWeather.description,
        mainCondition: currentWeather.mainCondition,
        humidity: currentWeather.humidity,
        windSpeed: currentWeather.windSpeed,
        rainChance: rainChance,
      );
    } catch (e) {
      print('Weather Service Error: $e');
      rethrow;
    }
  }

  Future<List<HourlyForecastModel>> getHourlyForecast(String cityName) async {
    try {
      final forecastUrl = Uri.parse(
        '$baseUrl/forecast?q=$cityName&appid=$apiKey&units=metric',
      );

      final response = await http.get(forecastUrl);

      if (response.statusCode != 200) {
        throw Exception('Unable to retrieve hourly forecast');
      }

      final forecastData = jsonDecode(response.body);

      final List forecastList = forecastData['list'];

      return forecastList
          .map((forecast) => HourlyForecastModel.fromJson(forecast))
          .toList();
    } catch (e) {
      print('Hourly Forecast Error: $e');
      rethrow;
    }
  }
}
