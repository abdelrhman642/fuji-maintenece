import 'dart:convert';

class EditClientLocationRequest {
  int? clientId;
  double? longitude;
  double? latitude;
  String? location;

  EditClientLocationRequest({
    this.clientId,
    this.longitude,
    this.latitude,
    this.location,
  });

  @override
  String toString() {
    return 'EditClientLocationRequest(clientId: $clientId, longitude: $longitude, latitude: $latitude, location: $location)';
  }

  factory EditClientLocationRequest.fromMap(Map<String, dynamic> data) {
    return EditClientLocationRequest(
      clientId: data['client_id'] as int?,
      longitude: (data['longitude'] as num?)?.toDouble(),
      latitude: (data['latitude'] as num?)?.toDouble(),
      location: data['location'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'client_id': clientId,
    'longitude': longitude,
    'latitude': latitude,
    'location': location,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EditClientLocationRequest].
  factory EditClientLocationRequest.fromJson(String data) {
    return EditClientLocationRequest.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [EditClientLocationRequest] to a JSON string.
  String toJson() => json.encode(toMap());
}
