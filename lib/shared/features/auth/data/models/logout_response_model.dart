/// Logout response model for API calls
class LogoutResponseModel {
  final String message;

  LogoutResponseModel({required this.message});

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  String toString() {
    return 'LogoutResponseModel(message: $message)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogoutResponseModel &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
