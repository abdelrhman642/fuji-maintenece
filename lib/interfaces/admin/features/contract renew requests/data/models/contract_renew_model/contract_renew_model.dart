import 'dart:convert';

import 'client.dart';
import 'contract.dart';
import 'handled_by.dart';

class ContractRenewModel {
  int? id;
  int? contractId;
  int? clientId;
  String? status;
  String? clientNote;
  dynamic adminReason;
  HandledBy? handledBy;
  DateTime? handledAt;
  DateTime? requestedRenewalStartDate;
  dynamic requestedRenewalEndDate;
  dynamic requestedContractPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic newContractId;
  bool? isPending;
  bool? isApproved;
  bool? isRejected;
  Contract? contract;
  Client? client;

  ContractRenewModel({
    this.id,
    this.contractId,
    this.clientId,
    this.status,
    this.clientNote,
    this.adminReason,
    this.handledBy,
    this.handledAt,
    this.requestedRenewalStartDate,
    this.requestedRenewalEndDate,
    this.requestedContractPrice,
    this.createdAt,
    this.updatedAt,
    this.newContractId,
    this.isPending,
    this.isApproved,
    this.isRejected,
    this.contract,
    this.client,
  });

  @override
  String toString() {
    return 'ContractRenewModel(id: $id, contractId: $contractId, clientId: $clientId, status: $status, clientNote: $clientNote, adminReason: $adminReason, handledBy: $handledBy, handledAt: $handledAt, requestedRenewalStartDate: $requestedRenewalStartDate, requestedRenewalEndDate: $requestedRenewalEndDate, requestedContractPrice: $requestedContractPrice, createdAt: $createdAt, updatedAt: $updatedAt, newContractId: $newContractId, isPending: $isPending, isApproved: $isApproved, isRejected: $isRejected, contract: $contract, client: $client)';
  }

  factory ContractRenewModel.fromMap(Map<String, dynamic> data) {
    return ContractRenewModel(
      id: data['id'] as int?,
      contractId: data['contract_id'] as int?,
      clientId: data['client_id'] as int?,
      status: data['status'] as String?,
      clientNote: data['client_note'] as String?,
      adminReason: data['admin_reason'] as dynamic,
      handledBy:
          data['handled_by'] == null
              ? null
              : HandledBy.fromMap(data['handled_by'] as Map<String, dynamic>),
      handledAt:
          data['handled_at'] == null
              ? null
              : DateTime.parse(data['handled_at'] as String),
      requestedRenewalStartDate:
          data['requested_renewal_start_date'] == null
              ? null
              : DateTime.parse(data['requested_renewal_start_date'] as String),
      requestedRenewalEndDate: data['requested_renewal_end_date'] as dynamic,
      requestedContractPrice: data['requested_contract_price'] as dynamic,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
      newContractId: data['new_contract_id'] as dynamic,
      isPending: data['is_pending'] as bool?,
      isApproved: data['is_approved'] as bool?,
      isRejected: data['is_rejected'] as bool?,
      contract:
          data['contract'] == null
              ? null
              : Contract.fromMap(data['contract'] as Map<String, dynamic>),
      client:
          data['client'] == null
              ? null
              : Client.fromMap(data['client'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'contract_id': contractId,
    'client_id': clientId,
    'status': status,
    'client_note': clientNote,
    'admin_reason': adminReason,
    'handled_by': handledBy?.toMap(),
    'handled_at': handledAt?.toIso8601String(),
    'requested_renewal_start_date':
        requestedRenewalStartDate?.toIso8601String(),
    'requested_renewal_end_date': requestedRenewalEndDate,
    'requested_contract_price': requestedContractPrice,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'new_contract_id': newContractId,
    'is_pending': isPending,
    'is_approved': isApproved,
    'is_rejected': isRejected,
    'contract': contract?.toMap(),
    'client': client?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContractRenewModel].
  factory ContractRenewModel.fromJson(String data) {
    return ContractRenewModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ContractRenewModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
