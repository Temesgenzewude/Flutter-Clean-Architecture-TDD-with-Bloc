import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';

import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia({required this.repository});

  Future<Either<Failure, NumberTrivia>> call() async {
    return await repository.getRandomNumberTrivia();
  }
}
