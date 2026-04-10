class StoreNeighborhoodRequestModel {
  String nameEn;
  String nameAr;
  int cityId;

  StoreNeighborhoodRequestModel({
    required this.nameEn,
    required this.nameAr,
    required this.cityId,
  });

  factory StoreNeighborhoodRequestModel.fromJson(Map<String, dynamic> json) {
    return StoreNeighborhoodRequestModel(
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      cityId: json['city_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'name_en': nameEn,
    'name_ar': nameAr,
    'city_id': cityId,
  };

  StoreNeighborhoodRequestModel copyWith({
    String? nameEn,
    String? nameAr,
    int? cityId,
  }) {
    return StoreNeighborhoodRequestModel(
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      cityId: cityId ?? this.cityId,
    );
  }
}
