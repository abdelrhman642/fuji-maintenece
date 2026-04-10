import 'dart:convert';

class TechnicianModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? status;
  dynamic image;
  String? location;
  String? longitude;
  String? latitude;
  DateTime? createdAt;

  TechnicianModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.status,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
    this.createdAt,
  });

  @override
  String toString() {
    return 'TechnicianModel(id: $id, name: $name, phone: $phone, email: $email, status: $status, image: $image, location: $location, longitude: $longitude, latitude: $latitude, createdAt: $createdAt)';
  }

  factory TechnicianModel.fromMap(Map<String, dynamic> data) {
    return TechnicianModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      phone: data['phone'] as String?,
      email: data['email'] as String?,
      status: data['status'] as String?,
      image: data['image'] as dynamic,
      location: data['location'] as String?,
      longitude: data['longitude'] as String?,
      latitude: data['latitude'] as String?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
    );
  }

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
    'created_at': createdAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TechnicianModel].
  factory TechnicianModel.fromJson(String data) {
    return TechnicianModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TechnicianModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
