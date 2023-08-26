import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivial_app/features/number_trivial/data/data_sources/number_trivia_local_data_source.dart';

@GenerateMocks(
  [NumberTriviaLocalDataSource],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
