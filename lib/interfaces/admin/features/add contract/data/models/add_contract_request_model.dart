import 'dart:convert';

class AddContractRequestModel {
  int? clientId;
  String? contractNumber;
  int? contractSectionId;
  String? startDate;
  String? endDate;
  int? contractDurationId;
  int? contractPrice;
  int? elevatorTypeId;
  int? elevatorModelId;
  String? location;
  double? longitude;
  double? latitude;

  AddContractRequestModel({
    this.clientId,
    this.contractNumber,
    this.contractSectionId,
    this.startDate,
    this.endDate,
    this.contractDurationId,
    this.contractPrice,
    this.elevatorTypeId,
    this.elevatorModelId,
    this.location,
    this.longitude,
    this.latitude,
  });

  @override
  String toString() {
    return 'AddContractRequestModel(clientId: $clientId, contractNumber: $contractNumber, contractSectionId: $contractSectionId, startDate: $startDate, endDate: $endDate, contractDurationId: $contractDurationId, contractPrice: $contractPrice, elevatorTypeId: $elevatorTypeId, elevatorModelId: $elevatorModelId, location: $location, longitude: $longitude, latitude: $latitude)';
  }

  factory AddContractRequestModel.fromMap(Map<String, dynamic> data) {
    return AddContractRequestModel(
      clientId: data['client_id'] as int?,
      contractNumber: data['contract_number'] as String?,
      contractSectionId: data['contract_section_id'] as int?,
      startDate: data['start_date'] as String?,
      endDate: data['end_date'] as String?,
      contractDurationId: data['contract_duration_id'] as int?,
      contractPrice: data['contract_price'] as int?,
      elevatorTypeId: data['elevator_type_id'] as int?,
      elevatorModelId: data['elevator_model_id'] as int?,
      location: data['location'] as String?,
      longitude: (data['longitude'] as num?)?.toDouble(),
      latitude: (data['latitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'client_id': clientId,
    'contract_number': contractNumber,
    'contract_section_id': contractSectionId,
    'start_date': startDate,
    'end_date': endDate,
    'contract_duration_id': contractDurationId,
    'contract_price': contractPrice,
    'elevator_type_id': elevatorTypeId,
    'elevator_model_id': elevatorModelId,
    'location': location,
    'longitude': longitude,
    'latitude': latitude,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddContractRequestModel].
  factory AddContractRequestModel.fromJson(String data) {
    return AddContractRequestModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AddContractRequestModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
