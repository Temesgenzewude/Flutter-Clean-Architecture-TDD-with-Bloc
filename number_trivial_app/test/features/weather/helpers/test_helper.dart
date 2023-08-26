import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// import WeatherRepository
import 'package:number_trivial_app/features/weather/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [WeatherRepository],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}  
