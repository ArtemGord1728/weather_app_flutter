import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/controller/weather_controller.dart';
import 'package:weather_app_test/custom/search_box.dart';
import 'package:weather_app_test/custom/weather_icon_image.dart';
import 'package:weather_app_test/data/weather_response.dart';

class CurrentWeather extends ConsumerWidget {

  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherControllerProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(city, style: Theme.of(context).textTheme.headline4),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(
              heightFactor: 1.0,
              child: CircularProgressIndicator()
          ),
          error: (e, __) => Text(e.toString()),
        ),
      ],
    );
  }

}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({Key? key, required this.data})
      : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celcius.toInt().toString();
    final minTemp = data.minTemp.celcius.toInt().toString();
    final maxTemp = data.maxTemp.celcius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        Text(temp, style: textTheme.headline2),
        Text(highAndLow, style: textTheme.bodyText2),
      ],
    );
  }
}