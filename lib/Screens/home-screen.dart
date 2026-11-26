import 'package:flutter/material.dart';

import 'map_screen.dart';
import '../services/Weather-Services.dart';
import '../Models/Weather-model.dart';

import '../widgets/current_weather.dart';
import '../widgets/hourly-forecast.dart';
import '../widgets/weather-details.dart';
import '../widgets/Lighting_inarea.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService = WeatherService();

  late Future<WeatherModel> weatherFuture;

  late Future<List<HourlyForecastModel>> forecastFuture;

  @override
  void initState() {
    super.initState();

    weatherFuture = weatherService.getWeather('Pretoria');

    forecastFuture = weatherService.getHourlyForecast('Pretoria');
  }

  // Search for another city
  void searchWeather(String city) {
    setState(() {
      weatherFuture = weatherService.getWeather(city);

      forecastFuture = weatherService.getHourlyForecast(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SkyCast',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // City search
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search city...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1B3152),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    searchWeather(value.trim());
                  }
                },
              ),

              const SizedBox(height: 25),

              // Current weather
              FutureBuilder<WeatherModel>(
                future: weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 45,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Unable to load weather.',
                            style: TextStyle(color: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              searchWeather('Pretoria');
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Text('No weather data available');
                  }

                  final weather = snapshot.data!;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.lightBlueAccent,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            weather.cityName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      CurrentWeather(weather: weather),

                      const SizedBox(height: 30),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Weather Details',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      WeatherDetails(weather: weather),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // Hourly forecast heading
              const Text(
                'Hourly Forecast (3-hour intervals)',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Live forecast
              FutureBuilder<List<HourlyForecastModel>>(
                future: forecastFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text(
                      'Unable to load forecast.',
                      style: TextStyle(color: Colors.white70),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                      'No forecast available.',
                      style: TextStyle(color: Colors.white70),
                    );
                  }

                  return HourlyForecast(forecast: snapshot.data!);
                },
              ),

              const SizedBox(height: 30),

              const LightingInArea(),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
