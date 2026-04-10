import '../cities_response_model/city_model.dart';

class NeighborhoodModel {
  int? id;
  int? cityId;
  String? nameAr;
  String? nameEn;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  CityModel? city;

  NeighborhoodModel({
    this.id,
    this.cityId,
    this.nameAr,
    this.nameEn,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.city,
  });

  factory NeighborhoodModel.fromJson(Map<String, dynamic> json) =>
      NeighborhoodModel(
        id: json['id'] as int?,
        cityId: json['city_id'] as int?,
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
        city:
            json['city'] == null
                ? null
                : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'city_id': cityId,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'city': city?.toJson(),
  };
}
