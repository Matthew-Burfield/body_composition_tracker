import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, double> stringToDouble(String str) {
    try {
      final result = double.parse(str);
      if (result < 0) {
        throw const FormatException();
      }
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
