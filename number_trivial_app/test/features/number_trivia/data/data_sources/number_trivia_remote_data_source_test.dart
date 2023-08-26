import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/mockito.dart';
import 'package:number_trivial_app/core/errors/exceptions.dart';
import 'package:number_trivial_app/features/number_trivial/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivial_app/features/number_trivial/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../helpers/moch_http_client.mocks.dart';

void main() {
  late MockClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async =>
            http.Response(readFixture("number_trivia_response.json"), 200));
  }

  void setUpHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(readFixture("number_trivia_response.json")));

    test('''should perform a GET request on a URL with number being
   the endpoint and with application/json header''', () {
      // arrange
      setUpHttpClientSuccess200();

      // act
      remoteDataSourceImpl.getConcreteNumberTrivia(tNumber);

      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200();

      // act
      final result =
          await remoteDataSourceImpl.getConcreteNumberTrivia(tNumber);

      // assert
      expect(result, tNumberTriviaModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpHttpClientFailure404();

      // act
      final call = remoteDataSourceImpl.getConcreteNumberTrivia;

      // assert
      expect(() => call(tNumber), throwsA(isA<ServerException>()));
    });
  });

  group("getRandomNumberTrivia", () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(readFixture("number_trivia_response.json")));

    test('''should perform a GET request on a URL with random being
   the endpoint and with application/json header''', () {
      // arrange
      setUpHttpClientSuccess200();

      // act
      remoteDataSourceImpl.getRandomNumberTrivia();

      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/random'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200();

      // act
      final result = await remoteDataSourceImpl.getRandomNumberTrivia();

      // assert
      expect(result, tNumberTriviaModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpHttpClientFailure404();

      // act
      final call = remoteDataSourceImpl.getRandomNumberTrivia;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
