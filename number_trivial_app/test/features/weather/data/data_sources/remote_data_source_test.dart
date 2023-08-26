import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:number_trivial_app/core/constants/constants.dart';
import 'package:number_trivial_app/features/weather/data/data_sources/remote_data_source.dart';
import 'package:number_trivial_app/features/weather/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });


  const tCity = "New York";
  group("get current weather", () {
    //test success scenario

    test('should return weather model when the response is 200', () {
      //arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(tCity),
          ),
        ),
      ).thenAnswer((_) async => http.Response(
          readJson(
              "/features/weather/helpers/dummy_data/dummy_weather_response.json"),
          200));
      //act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather(tCity);
      //assert

      expect(result, isA<WeatherModel>());
    });
  });
}
