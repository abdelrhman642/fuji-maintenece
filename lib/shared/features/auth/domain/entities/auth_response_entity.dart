import 'user_entity.dart';

class AuthResponseEntity {
  final String message;
  final String userType;
  final UserEntity user;
  final String token;
  final String refreshToken;
  final DateTime expiresAt;

  const AuthResponseEntity({
    required this.message,
    required this.userType,
    required this.user,
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
  });
}
