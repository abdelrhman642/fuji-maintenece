class UserEntity {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String status;
  final String? image;
  final String? location;
  final String? longitude;
  final String? latitude;
  final DateTime? phoneVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.status,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
    this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
