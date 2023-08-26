import 'package:dartz/dartz.dart';
import 'package:number_trivial_app/features/weather/domain/entities/weather.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase({required this.weatherRepository});

  Future<Either<Failure, WeatherEntity>> call(String cityName) async {
    return await weatherRepository.getCurrentWeather(cityName);
  }
}
