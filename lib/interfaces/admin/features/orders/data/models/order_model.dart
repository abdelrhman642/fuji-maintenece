class OrdersModel {
  bool? success;
  String? message;
  String? filterApplied;
  Null clientId;
  List<Data>? data;
  int? count;

  OrdersModel({
    this.success,
    this.message,
    this.filterApplied,
    this.clientId,
    this.data,
    this.count,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    filterApplied = json['filter_applied'];
    clientId = json['client_id'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['filter_applied'] = filterApplied;
    data['client_id'] = clientId;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  int? id;
  int? contractId;
  int? clientId;
  String? status;
  String? clientNote;
  Null adminReason;
  Null handledBy;
  Null handledAt;
  String? requestedRenewalStartDate;
  Null requestedRenewalEndDate;
  Null requestedContractPrice;
  String? transferImage;
  String? createdAt;
  String? updatedAt;
  Null newContractId;
  bool? isPending;
  bool? isApproved;
  bool? isRejected;
  Contract? contract;
  Client? client;

  Data({
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
    this.transferImage,
    this.createdAt,
    this.updatedAt,
    this.newContractId,
    this.isPending,
    this.isApproved,
    this.isRejected,
    this.contract,
    this.client,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractId = json['contract_id'];
    clientId = json['client_id'];
    status = json['status'];
    clientNote = json['client_note'];
    adminReason = json['admin_reason'];
    handledBy = json['handled_by'];
    handledAt = json['handled_at'];
    requestedRenewalStartDate = json['requested_renewal_start_date'];
    requestedRenewalEndDate = json['requested_renewal_end_date'];
    requestedContractPrice = json['requested_contract_price'];
    transferImage = json['transfer_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    newContractId = json['new_contract_id'];
    isPending = json['is_pending'];
    isApproved = json['is_approved'];
    isRejected = json['is_rejected'];
    contract =
        json['contract'] != null ? Contract.fromJson(json['contract']) : null;
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contract_id'] = contractId;
    data['client_id'] = clientId;
    data['status'] = status;
    data['client_note'] = clientNote;
    data['admin_reason'] = adminReason;
    data['handled_by'] = handledBy;
    data['handled_at'] = handledAt;
    data['requested_renewal_start_date'] = requestedRenewalStartDate;
    data['requested_renewal_end_date'] = requestedRenewalEndDate;
    data['requested_contract_price'] = requestedContractPrice;
    data['transfer_image'] = transferImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['new_contract_id'] = newContractId;
    data['is_pending'] = isPending;
    data['is_approved'] = isApproved;
    data['is_rejected'] = isRejected;
    if (contract != null) {
      data['contract'] = contract!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}

class Contract {
  int? id;
  int? clientId;
  String? contractNumber;
  int? contractSectionId;
  String? startDate;
  String? endDate;
  int? contractDurationId;
  String? contractPrice;
  int? elevatorTypeId;
  int? elevatorModelId;
  String? location;
  String? longitude;
  String? latitude;
  String? createdAt;
  String? updatedAt;
  String? status;
  bool? isCurrent;
  bool? isEnded;
  Client? client;
  ContractSection? contractSection;
  ContractDuration? contractDuration;
  ContractSection? elevatorType;
  ElevatorModel? elevatorModel;

  Contract({
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

  Contract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    contractNumber = json['contract_number'];
    contractSectionId = json['contract_section_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    contractDurationId = json['contract_duration_id'];
    contractPrice = json['contract_price'];
    elevatorTypeId = json['elevator_type_id'];
    elevatorModelId = json['elevator_model_id'];
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    isCurrent = json['is_current'];
    isEnded = json['is_ended'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    contractSection =
        json['contract_section'] != null
            ? ContractSection.fromJson(json['contract_section'])
            : null;
    contractDuration =
        json['contract_duration'] != null
            ? ContractDuration.fromJson(json['contract_duration'])
            : null;
    elevatorType =
        json['elevator_type'] != null
            ? ContractSection.fromJson(json['elevator_type'])
            : null;
    elevatorModel =
        json['elevator_model'] != null
            ? ElevatorModel.fromJson(json['elevator_model'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['contract_number'] = contractNumber;
    data['contract_section_id'] = contractSectionId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['contract_duration_id'] = contractDurationId;
    data['contract_price'] = contractPrice;
    data['elevator_type_id'] = elevatorTypeId;
    data['elevator_model_id'] = elevatorModelId;
    data['location'] = location;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['is_current'] = isCurrent;
    data['is_ended'] = isEnded;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (contractSection != null) {
      data['contract_section'] = contractSection!.toJson();
    }
    if (contractDuration != null) {
      data['contract_duration'] = contractDuration!.toJson();
    }
    if (elevatorType != null) {
      data['elevator_type'] = elevatorType!.toJson();
    }
    if (elevatorModel != null) {
      data['elevator_model'] = elevatorModel!.toJson();
    }
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? status;
  Null image;
  String? location;
  String? longitude;
  String? latitude;
  Null phoneVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Client({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.status,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
    this.phoneVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    image = json['image'];
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phoneVerifiedAt = json['phone_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['status'] = status;
    data['image'] = image;
    data['location'] = location;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ContractSection {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  String? createdAt;
  String? updatedAt;

  ContractSection({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ContractSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ContractDuration {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  int? monthCount;
  String? createdAt;
  String? updatedAt;

  ContractDuration({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.monthCount,
    this.createdAt,
    this.updatedAt,
  });

  ContractDuration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    status = json['status'];
    monthCount = json['month_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['status'] = status;
    data['month_count'] = monthCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ElevatorModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  int? elevatorTypeId;
  String? createdAt;
  String? updatedAt;

  ElevatorModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.elevatorTypeId,
    this.createdAt,
    this.updatedAt,
  });

  ElevatorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    status = json['status'];
    elevatorTypeId = json['elevator_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['status'] = status;
    data['elevator_type_id'] = elevatorTypeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
