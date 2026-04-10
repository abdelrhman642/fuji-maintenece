/// Models for maintenance system entities

/// Work Order model for technician interface
class WorkOrderItem {
  final String id;
  final String title;
  final String description;
  final String location;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? scheduledDate;
  final String? assignedTechnicianId;
  final String clientId;
  final String? equipmentId;

  WorkOrderItem({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.scheduledDate,
    this.assignedTechnicianId,
    required this.clientId,
    this.equipmentId,
  });

  factory WorkOrderItem.fromJson(Map<String, dynamic> json) {
    return WorkOrderItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      scheduledDate:
          json['scheduledDate'] != null
              ? DateTime.parse(json['scheduledDate'] as String)
              : null,
      assignedTechnicianId: json['assignedTechnicianId'] as String?,
      clientId: json['clientId'] as String,
      equipmentId: json['equipmentId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'priority': priority,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'scheduledDate': scheduledDate?.toIso8601String(),
      'assignedTechnicianId': assignedTechnicianId,
      'clientId': clientId,
      'equipmentId': equipmentId,
    };
  }
}

/// Maintenance Request model for client interface
class MaintenanceRequest {
  final String id;
  final String title;
  final String description;
  final String location;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String clientId;
  final String? technicianId;
  final String? technicianName;
  final List<String> images;

  MaintenanceRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.clientId,
    this.technicianId,
    this.technicianName,
    this.images = const [],
  });

  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequest(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt:
          json['completedAt'] != null
              ? DateTime.parse(json['completedAt'] as String)
              : null,
      clientId: json['clientId'] as String,
      technicianId: json['technicianId'] as String?,
      technicianName: json['technicianName'] as String?,
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'priority': priority,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'clientId': clientId,
      'technicianId': technicianId,
      'technicianName': technicianName,
      'images': images,
    };
  }
}

/// Equipment model
class Equipment {
  final String id;
  final String name;
  final String type;
  final String location;
  final String status;
  final DateTime lastMaintenanceDate;
  final DateTime? nextMaintenanceDate;
  final String? assignedTechnicianId;

  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.status,
    required this.lastMaintenanceDate,
    this.nextMaintenanceDate,
    this.assignedTechnicianId,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
      lastMaintenanceDate: DateTime.parse(
        json['lastMaintenanceDate'] as String,
      ),
      nextMaintenanceDate:
          json['nextMaintenanceDate'] != null
              ? DateTime.parse(json['nextMaintenanceDate'] as String)
              : null,
      assignedTechnicianId: json['assignedTechnicianId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location,
      'status': status,
      'lastMaintenanceDate': lastMaintenanceDate.toIso8601String(),
      'nextMaintenanceDate': nextMaintenanceDate?.toIso8601String(),
      'assignedTechnicianId': assignedTechnicianId,
    };
  }
}

/// Technician model
class Technician {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String specialization;
  final String status;
  final List<String> skills;
  final int experienceYears;
  final double rating;

  Technician({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
    required this.status,
    required this.skills,
    required this.experienceYears,
    required this.rating,
  });

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      specialization: json['specialization'] as String,
      status: json['status'] as String,
      skills: List<String>.from(json['skills'] ?? []),
      experienceYears: json['experienceYears'] as int,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'specialization': specialization,
      'status': status,
      'skills': skills,
      'experienceYears': experienceYears,
      'rating': rating,
    };
  }
}
