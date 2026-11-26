
import 'package:flutter/material.dart';
import '../Models/Weather-model.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyForecastModel> forecast;

  const HourlyForecast({
    super.key,
    required this.forecast,
  });

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;

      case 'clouds':
        return Icons.cloud;

      case 'rain':
      case 'drizzle':
        return Icons.grain;

      case 'thunderstorm':
        return Icons.thunderstorm;

      case 'snow':
        return Icons.ac_unit;

      default:
        return Icons.cloud_queue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3152),
        borderRadius: BorderRadius.circular(20),
      ),

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,

        itemBuilder: (context, index) {
          final weather = forecast[index];

          return Container(
            width: 75,
            margin: const EdgeInsets.only(right: 10),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,

              children: [

                // Forecast time
                Text(
                  TimeOfDay.fromDateTime(
                    weather.dateTime,
                  ).format(context),

                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),

                // Weather icon
                Icon(
                  getWeatherIcon(weather.condition),
                  color: Colors.amber,
                  size: 28,
                ),

                // Temperature
                Text(
                  '${weather.temperature.round()}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
