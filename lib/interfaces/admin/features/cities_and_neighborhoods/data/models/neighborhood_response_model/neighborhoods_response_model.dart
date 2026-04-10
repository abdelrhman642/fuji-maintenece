import 'neighborhood_model.dart';

class NeighborhoodsResponseModel {
  bool? success;
  String? message;
  List<NeighborhoodModel>? data;

  NeighborhoodsResponseModel({this.success, this.message, this.data});

  factory NeighborhoodsResponseModel.fromJson(Map<String, dynamic> json) {
    return NeighborhoodsResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => NeighborhoodModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
