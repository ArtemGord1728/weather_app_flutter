import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_test/custom/radio_button.dart';
import 'package:weather_app_test/utils/app_constants.dart';
import 'package:weather_app_test/utils/pref.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends ConsumerState<SettingsScreen> {

  bool status = false;
  int selectedButton = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    prefs = AppPref.localStorage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select calculation system", style: TextStyle(color: Colors.black),),
            RadioButton(
                text: 'Imperial',
                index: 0,
                selectedButton: prefs.getInt(AppConstants.selectedBtn),
                press: (val) {
                  selectedButton = val;
                  setState(() {
                    prefs.setString(AppConstants.unitsKeyToggle, "imperial");
                  });
                },),
            RadioButton(
                text: 'Metric',
                index: 1,
                selectedButton: prefs.getInt(AppConstants.selectedBtn),
                press: (val) {
                  selectedButton = val;
                  setState(() {
                    prefs.setString(AppConstants.unitsKeyToggle, "metric");
                  });
                }),
          ],
        ),
      ),
    );
  }

}