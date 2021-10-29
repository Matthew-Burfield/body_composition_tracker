import 'package:equatable/equatable.dart';

class MeasurementEntity extends Equatable {
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

  const MeasurementEntity({
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
  List<Object?> get props => [
        id,
        neck,
        chest,
        hips,
        waist,
        bicep,
        thigh,
        date,
        createdAt,
        editedAt,
      ];

  @override
  bool get stringify => true;
}
