import 'package:body_composition_tracker/core/error/exceptions.dart';
import 'package:body_composition_tracker/features/measurements/data/data_sources/measurement_data_source.dart';
import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';
import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';
import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/features/measurements/domain/repositories/measurement_repository.dart';
import 'package:dartz/dartz.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {
  final MeasurementDataSource dataSource;

  MeasurementRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, MeasurementEntity>> getMeasurementForDate(int date) {
    // TODO: implement getMeasurementForDate
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> saveMeasurement({
    int? id,
    required double neck,
    required double chest,
    required double hips,
    required double waist,
    required double bicep,
    required double thigh,
    required int date,
    int? createdAt,
    int? editedAt,
  }) async {
    // NOTE: I feel like this conversion should not be in the repository.
    // I'm not sure that the repository should depend on the model
    final now = DateTime.now().millisecondsSinceEpoch;
    print('creadedAt: $createdAt');
    MeasurementModel measurement = MeasurementModel(
      id: id,
      neck: neck,
      chest: chest,
      hips: hips,
      waist: waist,
      bicep: bicep,
      thigh: thigh,
      date: date,
      createdAt: createdAt ?? now,
      editedAt: now,
    );
    try {
      final measurementId = await dataSource.saveMeasurement(measurement);
      return Right(measurementId);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
