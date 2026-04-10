import 'dart:convert';

import 'elevator_type.dart';

class ElevatorBrandModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  int? elevatorTypeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  ElevatorType? elevatorType;

  ElevatorBrandModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.elevatorTypeId,
    this.createdAt,
    this.updatedAt,
    this.elevatorType,
  });

  @override
  String toString() {
    return 'ElevatorBrandModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, status: $status, elevatorTypeId: $elevatorTypeId, createdAt: $createdAt, updatedAt: $updatedAt, elevatorType: $elevatorType)';
  }

  factory ElevatorBrandModel.fromMap(Map<String, dynamic> data) {
    return ElevatorBrandModel(
      id: data['id'] as int?,
      nameAr: data['name_ar'] as String?,
      nameEn: data['name_en'] as String?,
      status: data['status'] as String?,
      elevatorTypeId: data['elevator_type_id'] as int?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
      elevatorType:
          data['elevator_type'] == null
              ? null
              : ElevatorType.fromMap(
                data['elevator_type'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
    'elevator_type_id': elevatorTypeId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'elevator_type': elevatorType?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ElevatorBrandModel].
  factory ElevatorBrandModel.fromJson(String data) {
    return ElevatorBrandModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ElevatorBrandModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
