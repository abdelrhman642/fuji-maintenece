import 'dart:convert';

class MaintenanceContractSectionModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  MaintenanceContractSectionModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'MaintenanceContractSectionModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory MaintenanceContractSectionModel.fromMap(Map<String, dynamic> data) {
    return MaintenanceContractSectionModel(
      id: data['id'] as int?,
      nameAr: data['name_ar'] as String?,
      nameEn: data['name_en'] as String?,
      status: data['status'] as String?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MaintenanceContractSectionModel].
  factory MaintenanceContractSectionModel.fromJson(String data) {
    return MaintenanceContractSectionModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [MaintenanceContractSectionModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
