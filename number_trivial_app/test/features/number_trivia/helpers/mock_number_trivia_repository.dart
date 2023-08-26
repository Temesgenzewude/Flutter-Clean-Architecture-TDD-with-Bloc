
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivial_app/features/number_trivial/domain/repositories/number_trivia_repository.dart';



@GenerateMocks(
  [NumberTriviaRepository],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
