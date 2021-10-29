import 'package:body_composition_tracker/core/error/exceptions.dart';
import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/features/measurements/data/data_sources/measurement_data_source.dart';
import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';
import 'package:body_composition_tracker/features/measurements/data/repositories/measurement_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/test_helpers.dart';

import 'measurement_repository_impl_test.mocks.dart';

@GenerateMocks([MeasurementDataSource])
void main() {
  late MeasurementRepositoryImpl repository;
  late MockMeasurementDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockMeasurementDataSource();
    repository = MeasurementRepositoryImpl(
      dataSource: mockDataSource,
    );
  });

  group('saveMeasurement', () {
    test(
        'Should save the data when the call to the datasource is successful and return the database id',
        () async {
      // arrange
      final tMeasurementModel = createMeasurementModel();
      when(mockDataSource.saveMeasurement(any)).thenAnswer((_) async => 1);

      // act
      final result = await repository.saveMeasurement(
        neck: tMeasurementModel.neck,
        chest: tMeasurementModel.chest,
        hips: tMeasurementModel.hips,
        waist: tMeasurementModel.waist,
        bicep: tMeasurementModel.bicep,
        thigh: tMeasurementModel.thigh,
        date: tMeasurementModel.date,
      );

      // assert
      expect(result, const Right(1));
      verify(mockDataSource.saveMeasurement(any));
    });

    test(
        'Should return [DatabaseFailure] when the call to the data source is unsuccessful',
        () async {
      // arrange
      final tMeasurementModel = createMeasurementModel();
      when(mockDataSource.saveMeasurement(any)).thenThrow(DatabaseException());

      // act
      final result = await repository.saveMeasurement(
        neck: tMeasurementModel.neck,
        chest: tMeasurementModel.chest,
        hips: tMeasurementModel.hips,
        waist: tMeasurementModel.waist,
        bicep: tMeasurementModel.bicep,
        thigh: tMeasurementModel.thigh,
        date: tMeasurementModel.date,
      );

      // assert
      verify(mockDataSource.saveMeasurement(any));
      expect(result, equals(Left(DatabaseFailure())));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('Should set the createdAt field for new measurements', () async {
      // arrange
      final tMeasurementModel = createMeasurementModel();
      when(mockDataSource.saveMeasurement(any)).thenAnswer((_) async => 1);

      // act
      final timeBeforeSaveCall = DateTime.now().millisecondsSinceEpoch;
      await repository.saveMeasurement(
        neck: tMeasurementModel.neck,
        chest: tMeasurementModel.chest,
        hips: tMeasurementModel.hips,
        waist: tMeasurementModel.waist,
        bicep: tMeasurementModel.bicep,
        thigh: tMeasurementModel.thigh,
        date: tMeasurementModel.date,
      );
      final timeAfterSaveCall = DateTime.now().millisecondsSinceEpoch;

      // assert
      final capturedParams =
          verify(mockDataSource.saveMeasurement(captureAny)).captured;
      final MeasurementModel savedMeasurement = capturedParams[0];
      expect(savedMeasurement.createdAt, isNotNull);
      expect(
          savedMeasurement.createdAt, greaterThanOrEqualTo(timeBeforeSaveCall));
      expect(savedMeasurement.createdAt, lessThanOrEqualTo(timeAfterSaveCall));
    });

    test(
        'Should save the existing measurement without modifing the createdAt field',
        () async {
      // arrange
      final createdAt = DateTime.now()
          .subtract(const Duration(days: 1))
          .millisecondsSinceEpoch;
      final tMeasurementModel = createMeasurementModel(
        overrides: MeasurementOverrides(
          id: 1,
          createdAt: createdAt,
        ),
      );
      when(mockDataSource.saveMeasurement(any)).thenAnswer((_) async => 1);

      // act
      await repository.saveMeasurement(
        id: tMeasurementModel.id,
        neck: tMeasurementModel.neck,
        chest: tMeasurementModel.chest,
        hips: tMeasurementModel.hips,
        waist: tMeasurementModel.waist,
        bicep: tMeasurementModel.bicep,
        thigh: tMeasurementModel.thigh,
        date: tMeasurementModel.date,
        createdAt: tMeasurementModel.createdAt,
      );

      // assert
      final capturedParams =
          verify(mockDataSource.saveMeasurement(captureAny)).captured;
      final MeasurementModel savedMeasurement = capturedParams[0];
      expect(savedMeasurement.createdAt, isNotNull);
      expect(savedMeasurement.createdAt, equals(createdAt));
    });

    test('Should set the editedAt field when saving a new measurement',
        () async {
      // arrange
      final tMeasurementModel = createMeasurementModel();
      when(mockDataSource.saveMeasurement(any)).thenAnswer((_) async => 1);

      // act
      await repository.saveMeasurement(
        neck: tMeasurementModel.neck,
        chest: tMeasurementModel.chest,
        hips: tMeasurementModel.hips,
        waist: tMeasurementModel.waist,
        bicep: tMeasurementModel.bicep,
        thigh: tMeasurementModel.thigh,
        date: tMeasurementModel.date,
      );

      // assert
      final capturedParams =
          verify(mockDataSource.saveMeasurement(captureAny)).captured;
      final MeasurementModel savedMeasurement = capturedParams[0];
      expect(savedMeasurement.editedAt, isNotNull);
    });

    test('Should set the editedAt field when saving an existing measurement',
        () async {
      // arrange
      final editedAt = DateTime.now().millisecondsSinceEpoch;
      final tMeasurementModel = createMeasurementModel(
          overrides: MeasurementOverrides(id: 1, editedAt: editedAt));
      when(mockDataSource.saveMeasurement(any)).thenAnswer((_) async => 1);

      // act
      final timeBeforeSaveCall = DateTime.now().millisecondsSinceEpoch;
      await repository.saveMeasurement(
        id: tMeasurementModel.id,
        neck: tMeasurementModel.neck,
        chest: tMeasurementModel.chest,
        hips: tMeasurementModel.hips,
        waist: tMeasurementModel.waist,
        bicep: tMeasurementModel.bicep,
        thigh: tMeasurementModel.thigh,
        date: tMeasurementModel.date,
        editedAt: tMeasurementModel.editedAt,
      );
      final timeAfterSaveCall = DateTime.now().millisecondsSinceEpoch;

      // assert
      final capturedParams =
          verify(mockDataSource.saveMeasurement(captureAny)).captured;
      final MeasurementModel savedMeasurement = capturedParams[0];
      expect(
          savedMeasurement.editedAt, greaterThanOrEqualTo(timeBeforeSaveCall));
      expect(savedMeasurement.editedAt, lessThanOrEqualTo(timeAfterSaveCall));
    });
  });
}
