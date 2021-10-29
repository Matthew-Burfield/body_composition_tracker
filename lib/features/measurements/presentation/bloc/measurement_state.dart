part of 'measurement_bloc.dart';

abstract class MeasurementState extends Equatable {
  const MeasurementState();
}

class Initial extends MeasurementState {
  @override
  List<Object?> get props => [];
}

class Loading extends MeasurementState {
  @override
  List<Object?> get props => [];
}

class Loaded extends MeasurementState {
  final MeasurementEntity measurement;

  const Loaded({required this.measurement});

  @override
  List<Object?> get props => [measurement];
}

class Error extends MeasurementState {
  final String message;

  const Error({required this.message});
  
  @override
  List<Object?> get props => [];
}
