/// User model for authentication and profile management
class User {
  final String id;
  final String email;
  final String name;
  final String userType;
  final String? phoneNumber;
  final String? profileImage;
  final DateTime? createdAt;
  final bool isActive;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    this.phoneNumber,
    this.profileImage,
    this.createdAt,
    this.isActive = true,
  });

  /// Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      userType: json['userType'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'createdAt': createdAt?.toIso8601String(),
      'isActive': isActive,
    };
  }

  /// Create a copy with updated values
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? userType,
    String? phoneNumber,
    String? profileImage,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ name.hashCode ^ userType.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, userType: $userType)';
  }
}
