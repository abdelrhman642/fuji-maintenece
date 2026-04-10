class StoreCityRequestModel {
  String nameEn;
  String nameAr;

  StoreCityRequestModel({required this.nameEn, required this.nameAr});

  factory StoreCityRequestModel.fromJson(Map<String, dynamic> json) {
    return StoreCityRequestModel(
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'name_en': nameEn, 'name_ar': nameAr};
}
