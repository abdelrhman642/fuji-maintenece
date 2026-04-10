class CityModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CityModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json['id'] as int?,
    nameAr: json['name_ar'] as String?,
    nameEn: json['name_en'] as String?,
    status: json['status'] as String?,
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    updatedAt:
        json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
