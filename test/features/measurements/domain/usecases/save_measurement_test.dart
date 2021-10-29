import 'package:body_composition_tracker/features/measurements/domain/repositories/measurement_repository.dart';
import 'package:body_composition_tracker/features/measurements/domain/usecases/save_measurement.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_measurement_for_date_test.mocks.dart';

@GenerateMocks([MeasurementRepository])
void main() {
  late MeasurementRepository mockRepository;
  late SaveMeasurement usecase;

  setUp(() {
    mockRepository = MockMeasurementRepository();
    usecase = SaveMeasurement(mockRepository);
  });

  const neck = 1.0;
  const chest = 1.0;
  const hips = 1.0;
  const waist = 1.0;
  const bicep = 1.0;
  const thigh = 1.0;
  final date = DateTime.now().millisecondsSinceEpoch;

  test('Should pass the measurement through to the repository', () async {
    // arrange
    when(mockRepository.saveMeasurement(
      neck: neck,
      chest: chest,
      hips: hips,
      waist: waist,
      bicep: bicep,
      thigh: thigh,
      date: date,
    )).thenAnswer((_) async => const Right(1));

    // act
    final result = await usecase(Params(
      neck: neck,
      chest: chest,
      hips: hips,
      waist: waist,
      bicep: bicep,
      thigh: thigh,
      date: date,
    ));

    // assert
    expect(result, const Right(1));
    verify(mockRepository.saveMeasurement(
      neck: neck,
      chest: chest,
      hips: hips,
      waist: waist,
      bicep: bicep,
      thigh: thigh,
      date: date,
    ));
    verifyNoMoreInteractions(mockRepository);
  });
}
