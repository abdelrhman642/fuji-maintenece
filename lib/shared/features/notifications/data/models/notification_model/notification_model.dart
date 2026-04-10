import 'dart:convert';

/// Model representing a notification in the system
class NotificationModel {
  final int? id;
  final String? title;
  final String? message;
  final String? type;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? data;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.data,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'] as int?,
      title: data['title'] as String?,
      message: data['message'] as String?,
      type: data['type'] as String?,
      isRead: data['is_read'] as bool? ?? data['isRead'] as bool? ?? false,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.tryParse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.tryParse(data['updated_at'] as String),
      data: data['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'message': message,
    'type': type,
    'is_read': isRead,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'data': data,
  };

  factory NotificationModel.fromJson(String data) {
    return NotificationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  NotificationModel copyWith({
    int? id,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      data: data ?? this.data,
    );
  }
}
