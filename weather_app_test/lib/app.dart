import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_test/db/weather_entity.dart';
import 'package:weather_app_test/screen/main_screen.dart';
import 'package:weather_app_test/utils/app_constants.dart';
import 'package:weather_app_test/utils/pref.dart';


void main() async {
  await Hive.initFlutter();
  await initLocalStorage();
  Hive.registerAdapter(WeatherCityAdapter());
  await Hive.openBox<WeatherCity>(AppConstants.entitiesBoxName);
  runApp(const ProviderScope(child: MyApp()));
}

Future initLocalStorage() async {
  await AppPref.init();
  AppPref.localStorage.setString(AppConstants.unitsKeyToggle, "imperial"); // default unit
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.25),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 0.5),
      )
    ]);
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline1: textStyleWithShadow,
          headline2: textStyleWithShadow,
          headline3: textStyleWithShadow,
          headline4: textStyleWithShadow,
          headline5: textStyleWithShadow,
          subtitle1: const TextStyle(color: Colors.white),
          bodyText2: const TextStyle(color: Colors.white),
          bodyText1: const TextStyle(color: Colors.white),
          caption: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
      home: const Scaffold(
        body: MainPage()
      )
    );
  }
}