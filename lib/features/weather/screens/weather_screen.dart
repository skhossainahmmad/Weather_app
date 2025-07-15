import 'package:flutter/material.dart';

import '../../utill/get_di.dart';
import '../controllers/weather_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final controller = sl<WeatherController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onWeatherUpdated);
    controller.loadWeather("Dhaka");
  }

  void _onWeatherUpdated() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onWeatherUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weather = controller.weather;

    if (controller.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (weather == null) {
      return const Scaffold(
        body: Center(child: Text("Failed to load weather data.")),
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text(
              weather.city,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "      ${weather.time}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "\n \n ${weather.date}"),
              ],
              style: DefaultTextStyle.of(context).style,
            ),
          ),
          Image.network(weather.iconUrl),
          Text(weather.weatherType),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${weather.temp}° c",
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: const Color.fromARGB(255, 27, 72, 94),
                elevation: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Max: ${weather.max}", style: const TextStyle(color: Colors.white)),
                        Text("Min: ${weather.min}", style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Wind: ${weather.wind}", style: const TextStyle(color: Colors.white)),
                        Text("Humidity: ${weather.humidity}", style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}