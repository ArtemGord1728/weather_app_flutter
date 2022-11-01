// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherCityAdapter extends TypeAdapter<WeatherCity> {
  @override
  final int typeId = 2;

  @override
  WeatherCity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherCity(
      cityName: fields[0] as String,
      temp: fields[1] as String,
      minTemp: fields[2] as String,
      maxTemp: fields[3] as String,
      highAndLow: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherCity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.minTemp)
      ..writeByte(3)
      ..write(obj.maxTemp)
      ..writeByte(4)
      ..write(obj.highAndLow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherCityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
