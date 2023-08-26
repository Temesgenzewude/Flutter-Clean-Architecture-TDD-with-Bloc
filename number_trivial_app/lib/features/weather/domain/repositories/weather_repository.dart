import 'package:dartz/dartz.dart';
import 'package:number_trivial_app/features/weather/domain/entities/weather.dart';

import '../../../../core/errors/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}