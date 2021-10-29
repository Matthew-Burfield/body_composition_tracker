import 'package:body_composition_tracker/features/measurements/domain/entities/measurement_entity.dart';

class MeasurementModel extends MeasurementEntity {
  const MeasurementModel({
    int? id,
    required double neck,
    required double chest,
    required double hips,
    required double waist,
    required double bicep,
    required double thigh,
    required int date,
    int? createdAt,
    int? editedAt,
  }) : super(
          id: id,
          neck: neck,
          chest: chest,
          hips: hips,
          waist: waist,
          bicep: bicep,
          thigh: thigh,
          date: date,
          createdAt: createdAt,
          editedAt: editedAt,
        );

  factory MeasurementModel.fromJson(Map<String, dynamic> jsonMap) {
    return MeasurementModel(
      id: jsonMap['id'],
      neck: jsonMap['neck'],
      chest: jsonMap['chest'],
      hips: jsonMap['hips'],
      waist: jsonMap['waist'],
      bicep: jsonMap['bicep'],
      thigh: jsonMap['thigh'],
      date: jsonMap['date'],
      createdAt: jsonMap['createdAt'],
      editedAt: jsonMap['editedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "neck": neck,
      "chest": chest,
      "hips": hips,
      "waist": waist,
      "bicep": bicep,
      "thigh": thigh,
      "date": date,
      "createdAt": createdAt,
      "editedAt": editedAt,
    };
  }
}
