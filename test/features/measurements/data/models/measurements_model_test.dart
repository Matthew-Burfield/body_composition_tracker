import 'dart:convert';

import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';
import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMeasurementModel = MeasurementModel(
    id: 1,
    neck: 1.0,
    chest: 1.0,
    hips: 1.0,
    waist: 1.0,
    bicep: 1.0,
    thigh: 1.0,
    date: 1631717552807,
    createdAt: 1631717552807,
    editedAt: 1631717552807,
  );

  test('Should be a subclass of MeasurementEntity', () {
    expect(tMeasurementModel, isA<MeasurementEntity>());
  });

  group('fromJson', () {
    test('Should return a model when the JSON number is an integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('measurement.json'));

      // act
      final result = MeasurementModel.fromJson(jsonMap);

      // assert
      expect(result, tMeasurementModel);
    });
  });

  group('toJson', () {
    test('Should return the correct json map when calling toJson', () {
      // act
      final result = tMeasurementModel.toJson();
      final expectedJson = {
        "id": 1,
        "neck": 1.0,
        "chest": 1.0,
        "hips": 1.0,
        "waist": 1.0,
        "bicep": 1.0,
        "thigh": 1.0,
        "date": 1631717552807,
        "createdAt": 1631717552807,
        "editedAt": 1631717552807,
      };

      // assert
      expect(result, expectedJson);
    });
  });
}
