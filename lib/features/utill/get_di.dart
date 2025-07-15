
import 'package:get_it/get_it.dart';

import '../weather/controllers/weather_controller.dart';
import '../weather/domain/services/weather_service.dart';

final sl = GetIt.instance;
void init() async {
  sl.registerLazySingleton(() => WeatherService());
  sl.registerLazySingleton(() => WeatherController(sl()));
}