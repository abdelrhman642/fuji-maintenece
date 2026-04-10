import 'dart:convert';

class AddClientRequestModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? image;
  String? location;
  String? longitude;
  String? latitude;

  AddClientRequestModel({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
  });

  @override
  String toString() {
    return 'AddClientRequestModel(name: $name, phone: $phone, email: $email, password: $password, passwordConfirmation: $passwordConfirmation, image: $image, location: $location, longitude: $longitude, latitude: $latitude)';
  }

  factory AddClientRequestModel.fromMap(Map<String, dynamic> data) {
    return AddClientRequestModel(
      name: data['name'] as String?,
      phone: data['phone'] as String?,
      email: data['email'] as String?,
      password: data['password'] as String?,
      passwordConfirmation: data['password_confirmation'] as String?,
      image: data['image'] as String?,
      location: data['location'] as String?,
      longitude: data['longitude'] as String?,
      latitude: data['latitude'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
    'image': image,
    'location': location,
    'longitude': longitude,
    'latitude': latitude,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddClientRequestModel].
  factory AddClientRequestModel.fromJson(String data) {
    return AddClientRequestModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AddClientRequestModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
