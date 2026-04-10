import 'user_entity.dart';

/// Profile response entity for the domain layer
class ProfileResponseEntity {
  final String userType;
  final UserEntity user;

  const ProfileResponseEntity({required this.userType, required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileResponseEntity &&
          runtimeType == other.runtimeType &&
          userType == other.userType &&
          user == other.user;

  @override
  int get hashCode => userType.hashCode ^ user.hashCode;
}
