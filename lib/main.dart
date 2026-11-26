
import 'package:flutter/material.dart';
import 'Screens/home-screen.dart';

void main() {
  runApp(const SkyCastApp());
}

class SkyCastApp extends StatelessWidget {
  const SkyCastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'SkyCast Weather',

      // Application theme
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101D35),
        primaryColor: const Color(0xFF1B3152),
        useMaterial3: true,
      ),

      // Starting screen
      home: const HomeScreen(),
    );
  }
}
