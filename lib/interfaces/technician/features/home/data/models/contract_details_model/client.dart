import 'dart:convert';

class Client {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? status;
  dynamic image;
  String? location;
  String? longitude;
  String? latitude;
  dynamic phoneVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Client({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.status,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
    this.phoneVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Client(id: $id, name: $name, phone: $phone, email: $email, status: $status, image: $image, location: $location, longitude: $longitude, latitude: $latitude, phoneVerifiedAt: $phoneVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Client.fromMap(Map<String, dynamic> data) => Client(
    id: data['id'] as int?,
    name: data['name'] as String?,
    phone: data['phone'] as String?,
    email: data['email'] as String?,
    status: data['status'] as String?,
    image: data['image'] as dynamic,
    location: data['location'] as String?,
    longitude: data['longitude'] as String?,
    latitude: data['latitude'] as String?,
    phoneVerifiedAt: data['phone_verified_at'] as dynamic,
    createdAt:
        data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
    updatedAt:
        data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'status': status,
    'image': image,
    'location': location,
    'longitude': longitude,
    'latitude': latitude,
    'phone_verified_at': phoneVerifiedAt,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Client].
  factory Client.fromJson(String data) {
    return Client.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Client] to a JSON string.
  String toJson() => json.encode(toMap());
}
