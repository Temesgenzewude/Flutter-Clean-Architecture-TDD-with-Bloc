import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:number_trivial_app/core/errors/failure.dart';
import 'package:number_trivial_app/core/utils/input_converter.dart';
import 'package:number_trivial_app/features/number_trivial/domain/entities/number_trivia.dart';
import 'package:number_trivial_app/features/number_trivial/presentation/bloc/number_trivia_bloc.dart';

import '../../helpers/mock_get_concrete_number_trivia_use_case.mocks.dart';
import '../../helpers/mock_get_random_number_trivia_use_case.mocks.dart';
import '../../helpers/mock_input_converter.mocks.dart';

void main() {
  late NumberTriviaBloc numberTriviaBloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    // assert
    expect(numberTriviaBloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    final tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = const NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        // act
        numberTriviaBloc
            .add(GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Left(InvalidInputFailure(message: "Invalid input")));
        // assert later
        final expected = [
          // The initial state is always emitted first
          Empty(),
          const Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        // act
        numberTriviaBloc
            .add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(number: any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        numberTriviaBloc
            .add(GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(number: any));
        // assert
        verify(mockGetConcreteNumberTrivia(number: tNumberParsed));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(number: any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        // act
        numberTriviaBloc
            .add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(number: any)).thenAnswer(
            (_) async => Left(ServerFailure(message: SERVER_FAILURE_MESSAGE)));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        // act
        numberTriviaBloc
            .add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = const NumberTrivia(number: 1, text: 'test trivia');

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        numberTriviaBloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia());
        // assert
        verify(mockGetRandomNumberTrivia());
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        // act
        numberTriviaBloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia()).thenAnswer(
            (_) async => Left(ServerFailure(message: SERVER_FAILURE_MESSAGE)));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        // act
        numberTriviaBloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia()).thenAnswer(
            (_) async => Left(CacheFailure(message: CACHE_FAILURE_MESSAGE)));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        // act
        numberTriviaBloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}
