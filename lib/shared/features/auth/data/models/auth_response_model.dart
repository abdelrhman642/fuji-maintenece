import 'user_model.dart';

/// API response wrapper
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data:
          fromJsonT != null && json['data'] != null
              ? fromJsonT(json['data'])
              : json['data'] as T?,
    );
  }
}

/// Authentication response model
class AuthResponseModel {
  final String message;
  final String userType;
  final UserModel user;
  final String token;

  AuthResponseModel({
    required this.message,
    required this.userType,
    required this.user,
    required this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: json['message'] as String? ?? '',
      userType: json['user_type'] as String? ?? '',
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user_type': userType,
      'user': user.toJson(),
      'token': token,
    };
  }
}
