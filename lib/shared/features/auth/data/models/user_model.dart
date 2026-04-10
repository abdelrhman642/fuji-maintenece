/// User model for API responses
class UserModel {
  final int id;
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
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
      'email': email,
      'name': name,
      'phone': phone,
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

  UserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? phone,
    String? status,
    String? image,
    String? location,
    String? longitude,
    String? latitude,
    DateTime? phoneVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
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
