
import 'package:hive/hive.dart';
import 'package:weather_app_test/data/weather.dart';
import 'package:weather_app_test/data/weather_response.dart';

part 'weather_entity.g.dart';

@HiveType(typeId: 2)
class WeatherCity {
  @HiveField(0)
  String cityName;

  @HiveField(1)
  String temp;

  @HiveField(2)
  String minTemp;

  @HiveField(3)
  String maxTemp;

  @HiveField(4)
  String highAndLow;

  WeatherCity({
    required this.cityName,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.highAndLow,
  });
}