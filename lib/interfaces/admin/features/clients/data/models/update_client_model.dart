import 'dart:convert';

/// Response model for client update API
class UpdateClientModel {
  Client? client;

  UpdateClientModel({this.client});

  UpdateClientModel.fromJson(Map<String, dynamic> json) {
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (client != null) {
      data['client'] = client!.toJson();
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
  dynamic image;
  String? location;
  String? longitude;
  String? latitude;
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
