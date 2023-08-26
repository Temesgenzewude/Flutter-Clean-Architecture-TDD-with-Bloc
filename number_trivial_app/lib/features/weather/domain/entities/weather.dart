import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final int humidity;
  final int pressure;
  final double temperature;

  const WeatherEntity({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.pressure,
    required this.temperature,
  });

  @override
  List<Object?> get props => [
        cityName,
        main,
        description,
        iconCode,
        humidity,
        pressure,
        temperature,
      ];
}
