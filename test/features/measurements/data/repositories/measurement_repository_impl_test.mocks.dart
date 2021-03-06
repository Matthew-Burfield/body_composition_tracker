// Mocks generated by Mockito 5.0.16 from annotations
// in body_composition_tracker/test/features/measurements/data/repositories/measurement_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:body_composition_tracker/features/measurements/data/data_sources/measurement_data_source.dart'
    as _i2;
import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [MeasurementDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMeasurementDataSource extends _i1.Mock
    implements _i2.MeasurementDataSource {
  MockMeasurementDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MeasurementModel>> getMeasurementForDate(int? date) =>
      (super.noSuchMethod(Invocation.method(#getMeasurementForDate, [date]),
              returnValue: Future<List<_i4.MeasurementModel>>.value(
                  <_i4.MeasurementModel>[]))
          as _i3.Future<List<_i4.MeasurementModel>>);
  @override
  _i3.Future<int> saveMeasurement(_i4.MeasurementModel? measurement) =>
      (super.noSuchMethod(Invocation.method(#saveMeasurement, [measurement]),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  String toString() => super.toString();
}
