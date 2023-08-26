import 'package:number_trivial_app/features/weather/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required String cityName,
    required double temperature,
    required String iconCode,
    required String description,
    required int humidity,
    required int pressure,
    required String main,
  }) : super(
          cityName: cityName,
          temperature: temperature,
          iconCode: iconCode,
          description: description,
          humidity: humidity,
          pressure: pressure,
          main: main,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'],
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      main: json['weather'][0]['main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': [
        {'icon': iconCode, 'description': description, 'main': main}
      ],
      'main': {
        'temp': temperature,
        'humidity': humidity,
        'pressure': pressure,
      },
      'name': cityName
    };
  }
}
