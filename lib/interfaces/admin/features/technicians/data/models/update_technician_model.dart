import 'dart:convert';

class UpdateTechnicianModel {
  Technician? technician;

  UpdateTechnicianModel({this.technician});

  UpdateTechnicianModel.fromJson(Map<String, dynamic> json) {
    technician =
        json['technician'] != null
            ? Technician.fromJson(json['technician'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (technician != null) {
      data['technician'] = technician!.toJson();
    }
    return data;
  }
}

class Technician {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? status;
  dynamic image;
  String? location;
  String? longitude;
  String? latitude;
  String? phoneVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Technician({
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

  Technician.fromJson(Map<String, dynamic> json) {
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
