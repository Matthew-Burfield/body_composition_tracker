import 'package:bloc/bloc.dart';
import 'package:body_composition_tracker/core/error/failures.dart';
import 'package:body_composition_tracker/core/util/input_converter.dart';
import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';
import 'package:body_composition_tracker/features/measurements/domain/usecases/get_measurement_for_date.dart';
import 'package:body_composition_tracker/features/measurements/domain/usecases/save_measurement.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'measurement_event.dart';
part 'measurement_state.dart';

// ignore: constant_identifier_names
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invaid input. The number must be a positive integer greater than zero.';

// ignore: constant_identifier_names
const String DATABASE_FAILURE_MESSAGE = 'Database failure';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final SaveMeasurement saveMeasurement;
  final GetMeasurementForDate getMeasurementForDate;
  final InputConverter inputConverter;

  MeasurementBloc({
    required this.saveMeasurement,
    required this.getMeasurementForDate,
    required this.inputConverter,
  }) : super(Initial()) {
    on<SaveMeasurementEvent>((event, emit) async {
      try {
        final neck = _convertMeasurementValueAndDoValidation(event.neck);
        final chest = _convertMeasurementValueAndDoValidation(event.chest);
        final hips = _convertMeasurementValueAndDoValidation(event.hips);
        final waist = _convertMeasurementValueAndDoValidation(event.waist);
        final bicep = _convertMeasurementValueAndDoValidation(event.bicep);
        final thigh = _convertMeasurementValueAndDoValidation(event.thigh);
        const date = 111;
        // final failureOrMeasurementId = await saveMeasurement(Params(
        //   neck: neck,
        //   chest: chest,
        //   hips: hips,
        //   waist: waist,
        //   bicep: bicep,
        //   thigh: thigh,
        //   date: date,
        // ));
      } on InvalidInputFailure {
        emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      }
    });
  }

  MeasurementState get initialState => Initial();

  // MeasurementState _eitherLoadedOrErrorState(
  //         Either<Failure, MeasurementEntity> either) =>
  //     either.fold(
  //       (l) => const Error(message: DATABASE_FAILURE_MESSAGE),
  //       (measurement) => Loaded(measurement: measurement),
  //     );

  double _convertMeasurementValueAndDoValidation(String measurementString) {
    final inputEither = inputConverter.stringToDouble(measurementString);
    final measurement = inputEither.fold(
      (_) => throw InvalidInputFailure(),
      (measurementDouble) => measurementDouble,
    );
    return measurement;
  }
}
