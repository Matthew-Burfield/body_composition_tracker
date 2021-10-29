import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// General failures
class DatabaseFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
