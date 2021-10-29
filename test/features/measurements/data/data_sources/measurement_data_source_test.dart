import 'package:body_composition_tracker/features/measurements/data/data_sources/measurement_data_source.dart';
import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/test_helpers.dart';

import 'measurement_data_source_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late MeasurementDataSourceImpl localDataSource;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    localDataSource = MeasurementDataSourceImpl(measurementsBox: mockBox);
  });


  group('isMeasurementFromDay', () {
    test(
        'Should return true when the measurement and compare date are the same',
        () {
      // arrange
      final date = DateTime.now().millisecondsSinceEpoch;
      final measurement =
          createMeasurementModel(overrides: MeasurementOverrides(date: date));

      // act
      final result = isMeasurementFromDay(measurement, date);

      // assert
      expect(result, true);
    });

    test(
        'Should return false when the measurement and compare date are different dates',
        () {
      // arrange
      final todayDate = DateTime.now().millisecondsSinceEpoch;
      final yesterdayDate = DateTime.now()
          .subtract(const Duration(days: 1))
          .millisecondsSinceEpoch;
      final measurement = createMeasurementModel(
          overrides: MeasurementOverrides(date: yesterdayDate));

      // act
      final result = isMeasurementFromDay(measurement, todayDate);

      // assert
      expect(result, false);
    });
  });

  group('saveMeasurement', () {
    test('Should add the measurement to the box and return the id', () async {
      // arrange
      final measurement = createMeasurementModel();
      when(mockBox.add(any)).thenAnswer((_) async => 1);

      // act
      final result = await localDataSource.saveMeasurement(measurement);

      // assert
      verify(mockBox.add(measurement));
      verifyNoMoreInteractions(mockBox);
      expect(result, 1);
    });

    test(
        'Should save the existing measurement and return its id if it exists in the model',
        () async {
      // arrange
      const id = 10;
      final measurement =
          createMeasurementModel(overrides: const MeasurementOverrides(id: id));
      when(mockBox.put(id, measurement)).thenAnswer((_) async => id);

      // act
      final result = await localDataSource.saveMeasurement(measurement);

      // assert
      verify(mockBox.put(id, measurement));
      verifyNoMoreInteractions(mockBox);
      expect(result, id);
    });

    test('Should get all the measurements that occur on a specific date',
        () async {
      // arrange
      final yesterday = DateTime.now()
          .subtract(const Duration(days: 1))
          .millisecondsSinceEpoch;
      final today = DateTime.now().millisecondsSinceEpoch;
      final yesterdayMeasurement = createMeasurementModel(
          overrides: MeasurementOverrides(id: 1, date: yesterday));
      final todayMeasurement = createMeasurementModel(
          overrides: MeasurementOverrides(id: 2, date: today));
      final Iterable<MeasurementModel> iterable = [
        yesterdayMeasurement,
        todayMeasurement
      ];
      when(mockBox.values).thenReturn(iterable);

      // act
      final result = await localDataSource.getMeasurementForDate(today);

      // assert
      final expected = [
        todayMeasurement,
      ];
      verify(mockBox.values);
      expect(result, expected);
    });
  });
}
