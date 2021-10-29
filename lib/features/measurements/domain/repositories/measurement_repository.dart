import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MeasurementRepository {
  Future<Either<Failure, MeasurementEntity>> getMeasurementForDate(
      int date);
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
  });
}
