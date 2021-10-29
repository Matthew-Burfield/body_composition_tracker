import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helpers.dart';

void main() {
  group('createMeasurementModel', () {
    test(
        'Should create a new measurement model with no overrides, the measurements should all be doubles and the id, createdAt and editedAt should all be null',
        () {
      // act
      final measurement = createMeasurementModel();

      // assert
      expect(measurement, isA<MeasurementModel>());
      expect(measurement.neck, isNotNull);
      expect(measurement.chest, isNotNull);
      expect(measurement.hips, isNotNull);
      expect(measurement.waist, isNotNull);
      expect(measurement.bicep, isNotNull);
      expect(measurement.thigh, isNotNull);
      expect(measurement.id, isNull);
      expect(measurement.createdAt, isNull);
      expect(measurement.editedAt, isNull);
    });

    test(
        'Should accept overides with will in turn set those values in the model',
        () async {
      // act
      const id = 1;
      final createdAt = DateTime.now()
          .subtract(const Duration(days: 2))
          .millisecondsSinceEpoch;
      final editedAt = DateTime.now()
          .subtract(const Duration(days: 1))
          .millisecondsSinceEpoch;
      final measurement = createMeasurementModel(
          overrides: MeasurementOverrides(
        id: id,
        createdAt: createdAt,
        editedAt: editedAt,
      ));

      // assert
      expect(measurement.id, equals(id));
      expect(measurement.createdAt, equals(createdAt));
      expect(measurement.editedAt, equals(editedAt));
    });
  });
}
