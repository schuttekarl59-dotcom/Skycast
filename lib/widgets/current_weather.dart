import 'package:flutter/material.dart';

import '../Models/Weather-model.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: const Color(0xFF1B3152),
        borderRadius: BorderRadius.circular(25),
      ),

      child: Column(
        children: [
          const Icon(Icons.cloud, color: Colors.white70, size: 90),

          const SizedBox(height: 10),

          Text(
            '${weather.temperature.round()}°',
            style: const TextStyle(
              fontSize: 75,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Text(
            weather.description,
            style: const TextStyle(fontSize: 21, color: Colors.white),
          ),

          const SizedBox(height: 10),

          // High and low temperatures
          Text(
            'H: ${weather.maxTemperature.round()}°'
            '    L: ${weather.minTemperature.round()}°',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

