import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/core/usecases/usecase.dart';
import 'package:body_composition_tracker/features/measurements/domain/repositories/measurement_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveMeasurement extends UseCase<int, Params> {
  final MeasurementRepository _repository;

  SaveMeasurement(this._repository);

  @override
  Future<Either<Failure, int>> call(Params params) {
    return _repository.saveMeasurement(
      id: params.id,
      neck: params.neck,
      chest: params.chest,
      hips: params.hips,
      waist: params.waist,
      bicep: params.bicep,
      thigh: params.thigh,
      date: params.date,
      createdAt: params.createdAt,
      editedAt: params.editedAt,
    );
  }
}

class Params extends Equatable {
  final int? id;
  final double neck;
  final double chest;
  final double hips;
  final double waist;
  final double bicep;
  final double thigh;
  final int date;
  final int? createdAt;
  final int? editedAt;

  const Params({
    this.id,
    required this.neck,
    required this.chest,
    required this.hips,
    required this.waist,
    required this.bicep,
    required this.thigh,
    required this.date,
    this.createdAt,
    this.editedAt,
  });

  @override
  List<Object?> get props => [neck, chest, hips, waist, bicep, thigh, date];
}
