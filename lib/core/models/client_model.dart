import 'dart:convert';

class ClientModel {
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
  int? contractsCount;
  int? reportsCount;

  ClientModel({
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
    this.contractsCount,
    this.reportsCount,
  });

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, phone: $phone, email: $email, status: $status, image: $image, location: $location, longitude: $longitude, latitude: $latitude, createdAt: $createdAt, contractsCount: $contractsCount, reportsCount: $reportsCount)';
  }

  factory ClientModel.fromMap(Map<String, dynamic> data) => ClientModel(
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
    contractsCount: (data['contracts_count'] as int?) ?? 0,
    reportsCount: (data['reports_count'] as int?) ?? 0,
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
    'created_at': createdAt?.toIso8601String(),
    'contracts_count': contractsCount ?? 0,
    'reports_count': reportsCount ?? 0,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ClientModel].
  factory ClientModel.fromJson(String data) {
    return ClientModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ClientModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
