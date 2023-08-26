import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivial_app/features/weather/data/models/weather_model.dart';
import 'package:number_trivial_app/features/weather/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';
// import dummy data

/*
New York, Clouds, overcast clouds, 04d, 60, 1003, 298.25
*/
void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'New York',
    temperature: 298.25,
    iconCode: '04d',
    description: 'overcast clouds',
    humidity: 60,
    pressure: 1003,
    main: 'Clouds',
  );

  test('should be a subclass of WeatherEntity', () async {
    // assert
    expect(tWeatherModel, isA<WeatherEntity>());
  });

  // test fromJson

  test("should return valid WeatherModel from json", () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(readJson(
        "/features/weather/helpers/dummy_data/dummy_weather_response.json"));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, equals(tWeatherModel));
  });

  // test toJson

  test("should return valid json from WeatherModel", () async {
    // act
    final result = tWeatherModel.toJson();

    // assert
    final expectedJsonMap = {
      "weather": [
        {"icon": "04d", "description": "overcast clouds", "main": "Clouds"}
      ],
      "main": {"temp": 298.25, "humidity": 60, "pressure": 1003},
      "name": "New York"
    };
    expect(result, equals(expectedJsonMap));
  });
}
