import 'package:body_composition_tracker/features/measurements/data/models/measurement_model.dart';
import 'package:hive/hive.dart';

abstract class MeasurementDataSource {
  /// Gets the [MeasurementModel] from the database
  ///
  /// Throws a [DatabaseException] if it doesn't exist in the db.
  Future<List<MeasurementModel>> getMeasurementForDate(int date);

  /// Creates a new [MeasurementModel] in the database if none exists, or updates if it does
  ///
  /// Throws a [DatabaseException] if the transaction fails
  Future<int> saveMeasurement(MeasurementModel measurement);
}

const HIVE_BOX = 'measurements';

class MeasurementDataSourceImpl implements MeasurementDataSource {
  final Box<dynamic> measurementsBox;

  MeasurementDataSourceImpl({required this.measurementsBox});

  @override
  Future<List<MeasurementModel>> getMeasurementForDate(int date) async {
    final Iterable<MeasurementModel> measurements =
        measurementsBox.values.cast();
    final result = measurements
        .where((measurement) => isMeasurementFromDay(measurement, date))
        .toList();
    return result;
  }

  @override
  Future<int> saveMeasurement(MeasurementModel measurement) async {
    if (measurement.id == null) {
      // Create a new measurement and return it's id
      return await measurementsBox.add(measurement);
    }
    // Update the existing measurement and return it's id
    await measurementsBox.put(measurement.id, measurement);
    return measurement.id as int;
  }
}

bool isMeasurementFromDay(MeasurementModel measurement, int dateEpoc) {
  final compareDate = DateTime.fromMillisecondsSinceEpoch(dateEpoc);
  final measurementDate = DateTime.fromMillisecondsSinceEpoch(measurement.date);
  return measurementDate.isSameDate(compareDate);
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime compareDate) {
    return year == compareDate.year &&
        month == compareDate.month &&
        day == compareDate.day;
  }
}
