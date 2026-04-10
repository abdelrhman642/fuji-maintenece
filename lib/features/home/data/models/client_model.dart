import 'package:flutter_project/features/home/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  ClientModel({
    required super.registrationNumber,
    required super.name,
    required super.phoneNumber,
    required super.address,
    required super.contractDate,
    required super.namingContract,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      registrationNumber: json['registrationNumber'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      contractDate: json['contractDate'],
      namingContract: json['namingContract'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registrationNumber': registrationNumber,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'contractDate': contractDate,
      'namingContract': namingContract,
    };
  }
}
