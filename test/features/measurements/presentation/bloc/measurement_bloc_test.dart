import 'package:body_composition_tracker/core/util/input_converter.dart';
import 'package:body_composition_tracker/features/measurements/domain/usecases/get_measurement_for_date.dart';
import 'package:body_composition_tracker/features/measurements/domain/usecases/save_measurement.dart';
import 'package:body_composition_tracker/features/measurements/presentation/bloc/measurement_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'measurement_bloc_test.mocks.dart';

@GenerateMocks([SaveMeasurement, GetMeasurementForDate, InputConverter])
void main() {
  late MeasurementBloc bloc;
  late MockSaveMeasurement mockSaveMeasurement;
  late MockGetMeasurementForDate mockGetMeasurementForDate;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockSaveMeasurement = MockSaveMeasurement();
    mockGetMeasurementForDate = MockGetMeasurementForDate();
    mockInputConverter = MockInputConverter();
    bloc = MeasurementBloc(
      saveMeasurement: mockSaveMeasurement,
      getMeasurementForDate: mockGetMeasurementForDate,
      inputConverter: mockInputConverter,
    );
  });

  test('Should have the initial state of the MeasurementBloc be Empty', () {
    // assert
    expect(bloc.initialState, equals(Initial()));
  });

  group('SaveMeasurement', () {
    const tNeck = '1';
    const tWaist = '1';
    const tChest = '1';
    const tHips = '1';
    const tBicep = '1';
    const tThigh = '1';
    const tDate = '1';
    test(
        'Should call the InputConverter to validate and convert the values from strings to doubles',
        () async {
      // arrange
      when(mockInputConverter.stringToDouble('1')).thenReturn(const Right(1));
      when(mockSaveMeasurement(any)).thenAnswer((_) async => const Right(1));

      // act
      bloc.add(const SaveMeasurementEvent(
        neck: tNeck,
        chest: tChest,
        hips: tHips,
        waist: tWaist,
        bicep: tBicep,
        thigh: tThigh,
        date: tDate,
      ));
      await untilCalled(mockInputConverter.stringToDouble(any));

      // assert
      verify(mockInputConverter.stringToDouble(any)).called(6);
    });
  });
}
