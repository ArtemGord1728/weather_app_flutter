import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/custom/search_box.dart';
import 'package:weather_app_test/data/forecast_response.dart';
import 'package:weather_app_test/repository/api_error.dart';
import 'package:weather_app_test/repository/weather_repository.dart';
import 'package:weather_app_test/utils/app_constants.dart';
import 'package:weather_app_test/utils/pref.dart';

class HourlyWeatherController extends StateNotifier<AsyncValue<ForecastData>> {
  HourlyWeatherController(this._weatherRepository, {required String city, required String units})
      : super(const AsyncValue.loading()) {
    getWeather(city: city, units: units);
  }
  final HttpWeatherRepository _weatherRepository;

  Future<void> getWeather({required String city, required String units}) async {
    try {
      state = const AsyncValue.loading();
      final forecast = await _weatherRepository.getForecast(city: city, units: units);
      state = AsyncValue.data(ForecastData.from(forecast));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final hourlyWeatherControllerProvider = StateNotifierProvider.autoDispose<
    HourlyWeatherController, AsyncValue<ForecastData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(cityProvider);
  return HourlyWeatherController(
      weatherRepository, city: city,
      units: AppPref.localStorage.getString(AppConstants.unitsKeyToggle)
  );
});