import 'package:flutter/material.dart';

class LightingInArea extends StatelessWidget {
  const LightingInArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF1B3152),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget heading
          const Row(
            children: [
              Icon(Icons.flash_on, color: Colors.amber, size: 28),

              SizedBox(width: 10),

              Text(
                'Lightning in Your Area',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: const Color(0xFF263F62),
              borderRadius: BorderRadius.circular(15),
            ),

            child: const Row(
              children: [
                Icon(Icons.thunderstorm, color: Colors.amber, size: 40),

                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lighting Activity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text(
                        'Live lightning monitoring is not connected yet.',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Safety information
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orangeAccent,
                size: 22,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  'Stay indoors during thunderstorms. '
                  'Avoid open areas and tall objects.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
