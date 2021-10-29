import 'dart:math';

import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToDouble', () {
    test(
        'Should return a double when the string represents the unsigned interger 123',
        () {
      // arrange
      const str = '123';

      // act
      final result = inputConverter.stringToDouble(str);

      // assert
      expect(result, const Right(123));
    });

    test('Should return a double when the string represents the double 10.0',
        () {
      // arrange
      const str = '10.0';

      // act
      final result = inputConverter.stringToDouble(str);

      // assert
      expect(result, const Right(10.0));
    });

    test('Should return a failure when the string is not an integer', () {
      // arrange
      const str = 'abc';

      // act
      final result = inputConverter.stringToDouble(str);

      // assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('Should return a failure when the string is a negative number', () {
      // arrange
      const str = '-10';

      // act
      final result = inputConverter.stringToDouble(str);

      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
