import 'dart:convert';

class ElevatorModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  int? elevatorTypeId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ElevatorModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.elevatorTypeId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'ElevatorModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, status: $status, elevatorTypeId: $elevatorTypeId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory ElevatorModel.fromMap(Map<String, dynamic> data) => ElevatorModel(
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
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
    'elevator_type_id': elevatorTypeId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ElevatorModel].
  factory ElevatorModel.fromJson(String data) {
    return ElevatorModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ElevatorModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
