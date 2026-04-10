import 'dart:convert';

import 'client.dart';
import 'contract.dart';

class LocationUpdateRequestModel {
  int? id;
  int? clientId;
  int? contractId;
  String? status;
  dynamic reason;
  String? requestedLocation;
  String? requestedLongitude;
  String? requestedLatitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  Client? client;
  Contract? contract;

  LocationUpdateRequestModel({
    this.id,
    this.clientId,
    this.contractId,
    this.status,
    this.reason,
    this.requestedLocation,
    this.requestedLongitude,
    this.requestedLatitude,
    this.createdAt,
    this.updatedAt,
    this.client,
    this.contract,
  });

  @override
  String toString() {
    return 'LocationUpdateRequestModel(id: $id, clientId: $clientId, contractId: $contractId, status: $status, reason: $reason, requestedLocation: $requestedLocation, requestedLongitude: $requestedLongitude, requestedLatitude: $requestedLatitude, createdAt: $createdAt, updatedAt: $updatedAt, client: $client, contract: $contract)';
  }

  factory LocationUpdateRequestModel.fromMap(Map<String, dynamic> data) {
    return LocationUpdateRequestModel(
      id: data['id'] as int?,
      clientId: data['client_id'] as int?,
      contractId: data['contract_id'] as int?,
      status: data['status'] as String?,
      reason: data['reason'] as dynamic,
      requestedLocation: data['requested_location'] as String?,
      requestedLongitude: data['requested_longitude'] as String?,
      requestedLatitude: data['requested_latitude'] as String?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
      client:
          data['client'] == null
              ? null
              : Client.fromMap(data['client'] as Map<String, dynamic>),
      contract:
          data['contract'] == null
              ? null
              : Contract.fromMap(data['contract'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'client_id': clientId,
    'contract_id': contractId,
    'status': status,
    'reason': reason,
    'requested_location': requestedLocation,
    'requested_longitude': requestedLongitude,
    'requested_latitude': requestedLatitude,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'client': client?.toMap(),
    'contract': contract?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LocationUpdateRequestModel].
  factory LocationUpdateRequestModel.fromJson(String data) {
    return LocationUpdateRequestModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [LocationUpdateRequestModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
