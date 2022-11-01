import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_test/custom/search_box.dart';
import 'package:weather_app_test/data/weather.dart';
import 'package:weather_app_test/data/weather_response.dart';
import 'package:weather_app_test/db/weather_entity.dart';
import 'package:weather_app_test/repository/api_error.dart';
import 'package:weather_app_test/repository/weather_repository.dart';
import 'package:weather_app_test/utils/app_constants.dart';
import 'package:weather_app_test/utils/pref.dart';

class CurrentWeatherController extends StateNotifier<AsyncValue<WeatherData>> {
  CurrentWeatherController(this._weatherRepository, {required this.city, required this.units})
      : super(const AsyncValue.loading()) {
    getWeather(city: city, units: units);
  }
  final HttpWeatherRepository _weatherRepository;
  final String city;
  final String units;

  Future<void> getWeather({required String city, required String units}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherRepository.getWeather(city: city, units: units);
      state = AsyncValue.data(WeatherData.from(weather));
      _putEntity(city, weather);
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }

  void _putEntity(String city, Weather data) {
    Box<WeatherCity> citiesBox = Hive.box<WeatherCity>(AppConstants.entitiesBoxName);

    if(citiesBox.values.every((element) => element.cityName != city)) {
      citiesBox.add(WeatherCity(cityName: city,
          temp: data.weatherParams.temp.toString(),
          minTemp: data.weatherParams.tempMin.toString(),
          maxTemp: data.weatherParams.tempMax.toString(),
          highAndLow: 'H:${data.weatherParams.tempMax.toString()}° L:${data.weatherParams.tempMin.toString()}°'
      ));
    }
  }
}

final currentWeatherControllerProvider = StateNotifierProvider.autoDispose<
    CurrentWeatherController, AsyncValue<WeatherData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(cityProvider);
  return CurrentWeatherController(
      weatherRepository, city: city,
      units: AppPref.localStorage.getString(AppConstants.unitsKeyToggle)
  );
});