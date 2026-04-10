import 'dart:convert';

import 'client.dart';
import 'contract_duration.dart';
import 'contract_section.dart';
import 'elevator_model.dart';
import 'elevator_type.dart';

class ContractDetailsModel {
  int? id;
  int? clientId;
  String? contractNumber;
  int? contractSectionId;
  DateTime? startDate;
  DateTime? endDate;
  int? contractDurationId;
  String? contractPrice;
  int? elevatorTypeId;
  int? elevatorModelId;
  String? location;
  String? longitude;
  String? latitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  bool? isCurrent;
  bool? isEnded;
  Client? client;
  ContractSection? contractSection;
  ContractDuration? contractDuration;
  ElevatorType? elevatorType;
  ElevatorModel? elevatorModel;

  ContractDetailsModel({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.status,
    this.isCurrent,
    this.isEnded,
    this.client,
    this.contractSection,
    this.contractDuration,
    this.elevatorType,
    this.elevatorModel,
  });

  @override
  String toString() {
    return 'ContractDetailsModel(id: $id, clientId: $clientId, contractNumber: $contractNumber, contractSectionId: $contractSectionId, startDate: $startDate, endDate: $endDate, contractDurationId: $contractDurationId, contractPrice: $contractPrice, elevatorTypeId: $elevatorTypeId, elevatorModelId: $elevatorModelId, location: $location, longitude: $longitude, latitude: $latitude, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, isCurrent: $isCurrent, isEnded: $isEnded, client: $client, contractSection: $contractSection, contractDuration: $contractDuration, elevatorType: $elevatorType, elevatorModel: $elevatorModel)';
  }

  factory ContractDetailsModel.fromMap(Map<String, dynamic> data) {
    return ContractDetailsModel(
      id: data['id'] as int?,
      clientId: data['client_id'] as int?,
      contractNumber: data['contract_number'] as String?,
      contractSectionId: data['contract_section_id'] as int?,
      startDate:
          data['start_date'] == null
              ? null
              : DateTime.parse(data['start_date'] as String),
      endDate:
          data['end_date'] == null
              ? null
              : DateTime.parse(data['end_date'] as String),
      contractDurationId: data['contract_duration_id'] as int?,
      contractPrice: data['contract_price'] as String?,
      elevatorTypeId: data['elevator_type_id'] as int?,
      elevatorModelId: data['elevator_model_id'] as int?,
      location: data['location'] as String?,
      longitude: data['longitude'] as String?,
      latitude: data['latitude'] as String?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
      status: data['status'] as String?,
      isCurrent: data['is_current'] as bool?,
      isEnded: data['is_ended'] as bool?,
      client:
          data['client'] == null
              ? null
              : Client.fromMap(data['client'] as Map<String, dynamic>),
      contractSection:
          data['contract_section'] == null
              ? null
              : ContractSection.fromMap(
                data['contract_section'] as Map<String, dynamic>,
              ),
      contractDuration:
          data['contract_duration'] == null
              ? null
              : ContractDuration.fromMap(
                data['contract_duration'] as Map<String, dynamic>,
              ),
      elevatorType:
          data['elevator_type'] == null
              ? null
              : ElevatorType.fromMap(
                data['elevator_type'] as Map<String, dynamic>,
              ),
      elevatorModel:
          data['elevator_model'] == null
              ? null
              : ElevatorModel.fromMap(
                data['elevator_model'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'client_id': clientId,
    'contract_number': contractNumber,
    'contract_section_id': contractSectionId,
    'start_date': startDate?.toIso8601String(),
    'end_date': endDate?.toIso8601String(),
    'contract_duration_id': contractDurationId,
    'contract_price': contractPrice,
    'elevator_type_id': elevatorTypeId,
    'elevator_model_id': elevatorModelId,
    'location': location,
    'longitude': longitude,
    'latitude': latitude,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'status': status,
    'is_current': isCurrent,
    'is_ended': isEnded,
    'client': client?.toMap(),
    'contract_section': contractSection?.toMap(),
    'contract_duration': contractDuration?.toMap(),
    'elevator_type': elevatorType?.toMap(),
    'elevator_model': elevatorModel?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContractDetailsModel].
  factory ContractDetailsModel.fromJson(String data) {
    return ContractDetailsModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ContractDetailsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
