import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';

MeasurementModel createMeasurementModel({
  MeasurementOverrides overrides = const MeasurementOverrides(),
}) {
  final measurement = MeasurementModel(
    id: overrides.id,
    neck: overrides.neck,
    chest: overrides.chest,
    hips: overrides.hips,
    waist: overrides.waist,
    bicep: overrides.bicep,
    thigh: overrides.thigh,
    date: overrides.date,
    createdAt: overrides.createdAt,
    editedAt: overrides.editedAt,
  );
  return measurement;
}

class MeasurementOverrides {
  final double neck;
  final double chest;
  final double hips;
  final double waist;
  final double bicep;
  final double thigh;
  final int date;
  final int? id;
  final int? createdAt;
  final int? editedAt;

  const MeasurementOverrides({
    this.neck = 1.0,
    this.chest = 1.0,
    this.hips = 1.0,
    this.waist = 1.0,
    this.bicep = 1.0,
    this.thigh = 1.0,
    this.date = 1631717552807,
    this.id,
    this.createdAt,
    this.editedAt,
  });
}
