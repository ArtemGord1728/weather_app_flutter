import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_test/custom/search_box.dart';
import 'package:weather_app_test/db/weather_entity.dart';
import 'package:weather_app_test/screen/weather_screen.dart';
import 'package:weather_app_test/utils/app_constants.dart';

class CitiesListBox extends ConsumerStatefulWidget {

  const CitiesListBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CitiesListColumnState();
}

class _CitiesListColumnState extends ConsumerState<CitiesListBox> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
        valueListenable: Hive.box<WeatherCity>(AppConstants.entitiesBoxName).listenable(),
        builder: (context, box, _) {
          if (box.values.isEmpty) {
            return Center(
              heightFactor: 5.0,
              child: Text("Cities list is empty"),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              String city = box.getAt(index)!.cityName;
              return ListTile(
                title: Text(city, textAlign: TextAlign.center),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherScreen()));
                  ref.read(cityProvider.state).state = city;
                },
              );
            },
          );
        },
      ),
    ]
    );
  }

}