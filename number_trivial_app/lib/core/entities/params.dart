import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final String cityName;

  const Params({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
