import 'dart:convert';

class ContractModel {
  int? id;
  String? contractNumber;
  String? longitude;
  String? latitude;

  ContractModel({this.id, this.contractNumber, this.longitude, this.latitude});

  @override
  String toString() {
    return 'ContractModel(id: $id, contractNumber: $contractNumber, longitude: $longitude, latitude: $latitude)';
  }

  factory ContractModel.fromMap(Map<String, dynamic> data) => ContractModel(
    id: data['id'] as int?,
    contractNumber: data['contract_number'] as String?,
    longitude: data['longitude'] as String?,
    latitude: data['latitude'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'contract_number': contractNumber,
    'longitude': longitude,
    'latitude': latitude,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContractModel].
  factory ContractModel.fromJson(String data) {
    return ContractModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ContractModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
