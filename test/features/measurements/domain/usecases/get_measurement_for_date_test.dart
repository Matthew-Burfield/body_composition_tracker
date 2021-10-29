import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';
import 'package:body_composition_tracker/features/measurements/domain/repositories/measurement_repository.dart';
import 'package:body_composition_tracker/features/measurements/domain/usecases/get_measurement_for_date.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_measurement_for_date_test.mocks.dart';

@GenerateMocks([MeasurementRepository])
void main() {
  late MeasurementRepository mockRepository;
  late GetMeasurementForDate usecase;

  setUp(() {
    mockRepository = MockMeasurementRepository();
    usecase = GetMeasurementForDate(mockRepository);
  });

  final date = DateTime.now().millisecondsSinceEpoch;
  final measurement = MeasurementEntity(
    neck: 1.0,
    chest: 1.0,
    hips: 1.0,
    waist: 1.0,
    bicep: 1.0,
    thigh: 1.0,
    date: date,
  );

  test('Should return a measurement from the repository', () async {
    when(mockRepository.getMeasurementForDate(date))
        .thenAnswer((_) async => Right(measurement));

    final result = await usecase.execute(date: date);

    expect(result, Right(measurement));
    verify(mockRepository.getMeasurementForDate(date));
    verifyNoMoreInteractions(mockRepository);
  });
}
