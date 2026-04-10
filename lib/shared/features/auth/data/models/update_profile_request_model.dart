/// Update profile request model for API calls
class UpdateProfileRequestModel {
  final String? name;
  final String? phone;
  final String? email;
  final String? location;
  final double? longitude;
  final double? latitude;

  UpdateProfileRequestModel({
    this.name,
    this.phone,
    this.email,
    this.location,
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (email != null) data['email'] = email;
    if (location != null) data['location'] = location;
    if (longitude != null) data['longitude'] = longitude;
    if (latitude != null) data['latitude'] = latitude;

    return data;
  }

  /// Create from existing user data
  factory UpdateProfileRequestModel.fromUser({
    required String name,
    required String phone,
    required String email,
    required String location,
    required double longitude,
    required double latitude,
  }) {
    return UpdateProfileRequestModel(
      name: name,
      phone: phone,
      email: email,
      location: location,
      longitude: longitude,
      latitude: latitude,
    );
  }

  /// Create empty model for partial updates
  factory UpdateProfileRequestModel.empty() {
    return UpdateProfileRequestModel();
  }

  /// Copy with new values
  UpdateProfileRequestModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? location,
    double? longitude,
    double? latitude,
  }) {
    return UpdateProfileRequestModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  /// Check if any field is provided
  bool get isEmpty {
    return name == null &&
        phone == null &&
        email == null &&
        location == null &&
        longitude == null &&
        latitude == null;
  }

  /// Check if model has any data to update
  bool get hasData {
    return !isEmpty;
  }
}
