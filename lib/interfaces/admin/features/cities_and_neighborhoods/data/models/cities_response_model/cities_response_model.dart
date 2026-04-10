import 'city_model.dart';

class CitiesResponseModel {
  bool? success;
  String? message;
  List<CityModel>? data;

  CitiesResponseModel({this.success, this.message, this.data});

  factory CitiesResponseModel.fromJson(Map<String, dynamic> json) {
    return CitiesResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
