import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/api/open_weather_api.dart';
import 'package:weather_app_test/data/forecast.dart';
import 'package:weather_app_test/data/weather.dart';
import 'package:weather_app_test/repository/api_error.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app_test/utils/app_constants.dart';

class HttpWeatherRepository {
  HttpWeatherRepository({required this.api, required this.client});
  final OpenWeatherApi api;
  final http.Client client;

  Future<Forecast> getForecast({required String city, required String units}) => _getData(
    uri: api.forecast(city, units),
    builder: (data) => Forecast.fromJson(data),
  );

  Future<Weather> getWeather({required String city, required String units}) => _getData(
    uri: api.weather(city, units),
    builder: (data) => Weather.fromJson(data),
  );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw const APIError.invalidApiKey();
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }
}

final weatherRepositoryProvider = Provider<HttpWeatherRepository>((ref) {
  var apiKey = const String.fromEnvironment(
    'API_KEY',
    defaultValue: AppConstants.openWeatherApiKey,
  );
  return HttpWeatherRepository(
    api: OpenWeatherApi(apiKey),
    client: http.Client(),
  );
});