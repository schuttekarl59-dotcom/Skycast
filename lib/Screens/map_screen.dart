
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const LatLng pretoria = LatLng(
    -25.7479,
    28.2293,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101D35),

      appBar: AppBar(
        backgroundColor: const Color(0xFF101D35),
        foregroundColor: Colors.white,
        title: const Text(
          'Weather Map',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          // Location information
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            color: const Color(0xFF1B3152),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Location',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Pretoria, South Africa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Interactive map
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: pretoria,
                initialZoom: 11,
              ),

              children: [

                // Map tiles
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.skycast_weather',
                ),

                // Pretoria marker
                MarkerLayer(
                  markers: [
                    Marker(
                      point: pretoria,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom information
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            color: const Color(0xFF1B3152),
            child: const Row(
              children: [
                Icon(
                  Icons.map,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Explore locations using the map.',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
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
