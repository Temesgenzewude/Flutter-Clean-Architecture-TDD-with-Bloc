import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial_app/features/weather/domain/entities/weather.dart';
import 'package:number_trivial_app/features/weather/domain/use_cases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const tWeatherEntity = WeatherEntity(
      cityName: "New York",
      temperature: 39,
      humidity: 70,
      iconCode: '02d',
      main: 'Clouds',
      pressure: 1009,
      description: 'Few clouds');

  const tCityName = "New York";

  test("should get current weather detail from weather repository", () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(tCityName))
        .thenAnswer((_) async =>const Right(tWeatherEntity));

    // act
    final result = await getCurrentWeatherUseCase(tCityName);

    // assert
    expect(result, const Right(tWeatherEntity));
  });
}
