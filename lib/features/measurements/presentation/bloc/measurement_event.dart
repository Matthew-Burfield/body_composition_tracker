part of 'measurement_bloc.dart';

abstract class MeasurementEvent extends Equatable {
  const MeasurementEvent();
}

class SaveMeasurementEvent extends MeasurementEvent {
  final String neck;
  final String chest;
  final String hips;
  final String waist;
  final String bicep;
  final String thigh;
  final String date;

  const SaveMeasurementEvent({
    required this.neck,
    required this.chest,
    required this.hips,
    required this.waist,
    required this.bicep,
    required this.thigh,
    required this.date,
  });

  @override
  List<Object?> get props => [neck, chest, hips, waist, bicep, thigh, date];

  @override
  bool get stringify => true;
}
