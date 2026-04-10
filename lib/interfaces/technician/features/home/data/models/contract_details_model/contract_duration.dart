import 'dart:convert';

class ContractDuration {
  int? id;
  String? nameAr;
  String? nameEn;
  String? status;
  int? monthCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  ContractDuration({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
    this.monthCount,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'ContractDuration(id: $id, nameAr: $nameAr, nameEn: $nameEn, status: $status, monthCount: $monthCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory ContractDuration.fromMap(Map<String, dynamic> data) {
    return ContractDuration(
      id: data['id'] as int?,
      nameAr: data['name_ar'] as String?,
      nameEn: data['name_en'] as String?,
      status: data['status'] as String?,
      monthCount: data['month_count'] as int?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
    'month_count': monthCount,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContractDuration].
  factory ContractDuration.fromJson(String data) {
    return ContractDuration.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ContractDuration] to a JSON string.
  String toJson() => json.encode(toMap());
}
