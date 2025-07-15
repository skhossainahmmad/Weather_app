import 'package:flutter/material.dart';
import 'core/get_di.dart';
import 'features/weather/screens/weather_screen.dart';


void main() {
  init(); // initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
