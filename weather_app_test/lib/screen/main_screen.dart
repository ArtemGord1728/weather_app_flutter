import 'package:flutter/material.dart';
import 'package:weather_app_test/custom/search_box.dart';
import 'package:weather_app_test/screen/settings_screen.dart';
import 'package:weather_app_test/ui/cities_list_widget.dart';
import 'package:weather_app_test/utils/app_colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()))
        }, icon: const Icon(Icons.settings)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Spacer(),
              CitySearchBox(),
              CitiesListBox(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

}
