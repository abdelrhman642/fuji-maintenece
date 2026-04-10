class UpdateTechnicianRequest {
  String? name;
  String? phone;
  String? email;
  String? location;
  String? longitude;
  String? latitude;
  String? status;

  UpdateTechnicianRequest({
    this.name,
    this.phone,
    this.email,
    this.location,
    this.longitude,
    this.latitude,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (email != null) data['email'] = email;
    if (location != null) data['location'] = location;
    if (longitude != null) data['longitude'] = longitude;
    if (latitude != null) data['latitude'] = latitude;
    if (status != null) data['status'] = status;
    return data;
  }
}
