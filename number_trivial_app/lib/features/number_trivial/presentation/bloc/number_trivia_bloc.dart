// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia_use_case.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid input - the number must be a positive integer or zero';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>(_getTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_getTriviaForRandomNumber);
  }

  Future<void> _getTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

    inputEither.fold(
        (failure) => emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
        (integer) async{
      emit(Loading());
      final failureOrTrivia = await getConcreteNumberTrivia(number: integer);
      failureOrTrivia.fold(
          (failure) => emit(Error(message: _mapFailureToMessage(failure))),
          (trivia) => emit(Loaded(trivia: trivia)));
    });
  }

  Future<void> _getTriviaForRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia();
    failureOrTrivia.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (trivia) => emit(Loaded(trivia: trivia)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  // Stream<NumberTriviaState> mapEventToState(
  //   NumberTriviaEvent event,
  // ) async* {
  //   if (event is GetTriviaForConcreteNumber) {
  //     final inputEither =
  //         inputConverter.stringToUnsignedInteger(event.numberString);

  //     yield* inputEither.fold(
  //       (failure) async* {
  //         yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
  //       },
  //       // Although the "success case" doesn't interest us with the current test,
  //       // we still have to handle it somehow.
  //       (integer) async* {
  //         yield Loading();
  //         final failureOrTrivia = await getConcreteNumberTrivia(
  //           number: integer,
  //         );
  //         yield* _eitherLoadedOrErrorState(
  //           failureOrTrivia,
  //         );
  //       },
  //     );
  //   } else if (event is GetTriviaForRandomNumber) {
  //     yield Loading();
  //     final failureOrTrivia = await getRandomNumberTrivia();
  //     yield* _eitherLoadedOrErrorState(
  //       failureOrTrivia,
  //     );
  //   }
  // }
}
