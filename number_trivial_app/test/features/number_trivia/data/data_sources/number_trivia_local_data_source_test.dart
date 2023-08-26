import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:number_trivial_app/core/errors/exceptions.dart';
import 'package:number_trivial_app/features/number_trivial/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivial_app/features/number_trivial/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../helpers/mock_shared_preferences.mocks.dart';

// test number trivia local data source

void main() {
  late NumberTriviaLocalDataSourceImpl localDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(readFixture('trivia_cached.json')));

    test('should return the last number trivia when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(readFixture('trivia_cached.json'));
      // act
      final result = await localDataSourceImpl.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });
    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = localDataSourceImpl.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });



   
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =  NumberTriviaModel(
      number: 1,
      text: 'test trivia',
    );
    test('should call SharedPreferences to cache the data', () {
      // act
       localDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
