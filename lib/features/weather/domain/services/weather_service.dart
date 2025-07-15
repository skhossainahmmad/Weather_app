import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/app_constants.dart';
import '../model/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeather(String city) async {
    try {
      final url = Uri.parse(
          '${AppConstants.baseUrl}?key=${AppConstants.weatherKey}&q=$city&days=1&aqi=no&alerts=no'
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
