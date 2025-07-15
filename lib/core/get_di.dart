
import 'package:get_it/get_it.dart';

import '../features/weather/controllers/weather_controller.dart';
import '../features/weather/domain/services/weather_service.dart';

final sl = GetIt.instance;
void init() async {
  sl.registerLazySingleton(() => WeatherService());
  sl.registerLazySingleton(() => WeatherController(sl()));
}