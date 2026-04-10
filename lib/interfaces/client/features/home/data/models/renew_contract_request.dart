import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class RenewContractRequest {
  int? contractId;
  String? requestedRenewalStartDate;
  String? clientNote;
  File? transferImage;

  RenewContractRequest({
    this.contractId,
    this.requestedRenewalStartDate,
    this.clientNote,
    this.transferImage,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.add(MapEntry('contract_id', contractId.toString()));
    formData.fields.add(
      MapEntry('requested_renewal_start_date', requestedRenewalStartDate ?? ""),
    );
    formData.fields.add(MapEntry('client_note', clientNote ?? ""));

    if (transferImage != null) {
      formData.files.add(
        MapEntry(
          'transfer_image',
          await MultipartFile.fromFile(
            transferImage!.path,
            filename: transferImage!.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }

    return formData;
  }

  @override
  String toString() {
    return 'RenewContractRequest(contractId: $contractId, requestedRenewalStartDate: $requestedRenewalStartDate, clientNote: $clientNote, transferImage: $transferImage)';
  }

  factory RenewContractRequest.fromMap(Map<String, dynamic> data) {
    return RenewContractRequest(
      contractId: data['contract_id'] as int?,
      requestedRenewalStartDate:
          data['requested_renewal_start_date'] as String?,
      clientNote: data['client_note'] as String?,
      transferImage:
          data['transfer_image'] != null
              ? File(data['transfer_image'] as String)
              : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'contract_id': contractId,
    'requested_renewal_start_date': requestedRenewalStartDate,
    'client_note': clientNote,
    'transfer_image': transferImage?.path,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RenewContractRequest].
  factory RenewContractRequest.fromJson(String data) {
    return RenewContractRequest.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [RenewContractRequest] to a JSON string.
  String toJson() => json.encode(toMap());
}
