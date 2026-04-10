/// Profile response model that matches the API response structure
class ProfileResponseModel {
  final String userType;
  final UserProfileModel user;

  ProfileResponseModel({required this.userType, required this.user});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      userType: json['user_type'] as String,
      user: UserProfileModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_type': userType, 'user': user.toJson()};
  }
}

/// User profile model that matches the API user object structure
class UserProfileModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String status;
  final String? image;
  final String? location;
  final String? longitude;
  final String? latitude;
  final DateTime? phoneVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
    this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      image: json['image'] as String?,
      location: json['location'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      phoneVerifiedAt:
          json['phone_verified_at'] != null
              ? DateTime.parse(json['phone_verified_at'] as String)
              : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'status': status,
      if (image != null) 'image': image,
      if (location != null) 'location': location,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (phoneVerifiedAt != null)
        'phone_verified_at': phoneVerifiedAt!.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserProfileModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? status,
    String? image,
    String? location,
    String? longitude,
    String? latitude,
    DateTime? phoneVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
      image: image ?? this.image,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
