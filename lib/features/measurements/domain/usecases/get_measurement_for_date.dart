import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';
import 'package:body_composition_tracker/features/measurements/domain/repositories/measurement_repository.dart';
import 'package:dartz/dartz.dart';

class GetMeasurementForDate {
  final MeasurementRepository _repository;

  GetMeasurementForDate(this._repository);

  Future<Either<Failure, MeasurementEntity>> execute(
      {required int date}) async {
    return _repository.getMeasurementForDate(date);
  }
}
