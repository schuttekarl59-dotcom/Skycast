
import 'package:flutter/material.dart';
import '../Models/Weather-model.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetails({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        WeatherDetailCard(
          icon: Icons.water_drop,
          title: 'Humidity',
          value: '${weather.humidity}%',
        ),
        WeatherDetailCard(
          icon: Icons.air,
          title: 'Wind Speed',
          value: '${weather.windSpeed} m/s',
        ),
        WeatherDetailCard(
          icon: Icons.thermostat,
          title: 'Feels Like',
          value: '${weather.feelsLike.round()}°C',
        ),
       WeatherDetailCard(
          icon: Icons.umbrella,
          title: 'Rain Chance (24h)',
          value: '${weather.rainChance}%',
        ),
      ],
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3152),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.lightBlueAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
