import 'package:flutter/cupertino.dart';

import '../domain/model/weather_model.dart';
import '../domain/services/weather_service.dart';

class WeatherController extends ChangeNotifier {
  final WeatherService _service;

  WeatherController(this._service);

  WeatherModel? weather;
  bool isLoading = true;

  Future<void> loadWeather(String city) async {
    isLoading = true;
    notifyListeners();

    weather = await _service.fetchWeather(city);

    isLoading = false;
    notifyListeners();
  }
}