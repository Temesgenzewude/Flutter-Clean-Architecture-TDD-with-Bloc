import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivial_app/features/number_trivial/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel =
      NumberTriviaModel(number: 2, text: '2 is for test');

  test('should be a subclass of NumberTrivia entity', () async {
    // assert
    expect(tNumberTriviaModel, isA<NumberTriviaModel>());
  });

  group("test fromJson", () {
    test(
        "should return a valid NumberTriviaModel from json when the number is integer",
        () async {
      // arrange

      final Map<String, dynamic> jsonMap =
          json.decode(readFixture("number_trivia_response.json"));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        "should return a valid NumberTriviaModel from json when the number is double",
        () async {
      // arrange

      final Map<String, dynamic> jsonMap =
          json.decode(readFixture("number_trivia_double_response.json"));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });
  });

  group("test toJson", () {
    test("should return a json map containing the proper data", () async {
      // act
      final result = tNumberTriviaModel.toJson();
      // assert
      final expectedJsonMap = {"text": "2 is for test", "number": 2};
      expect(result, equals(expectedJsonMap));
    });
  });
}
