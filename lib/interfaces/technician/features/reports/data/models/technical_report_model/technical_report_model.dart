import 'dart:convert';

import 'contract.dart';
import 'questions_answer.dart';
import 'technician.dart';

class TechnicalReportModel {
  int? id;
  int? contractId;
  int? technicianId;
  String? reportType;
  List<QuestionsAnswer>? questionsAnswers;
  dynamic image;
  String? pdfPath;
  dynamic notes;
  String? price;
  String? vat;
  String? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isFixed;
  bool? isSpareChanged;
  Contract? contract;
  Technician? technician;

  TechnicalReportModel({
    this.id,
    this.contractId,
    this.technicianId,
    this.reportType,
    this.questionsAnswers,
    this.image,
    this.pdfPath,
    this.notes,
    this.price,
    this.vat,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.isFixed,
    this.isSpareChanged,
    this.contract,
    this.technician,
  });

  factory TechnicalReportModel.fromMap(Map<String, dynamic> data) {
    return TechnicalReportModel(
      id: data['id'] as int?,
      contractId: data['contract_id'] as int?,
      technicianId: data['technician_id'] as int?,
      reportType: data['report_type'] as String?,
      questionsAnswers:
          (data['questions_answers'] as List<dynamic>?)
              ?.map((e) => QuestionsAnswer.fromMap(e as Map<String, dynamic>))
              .toList(),
      image: data['image'] as dynamic,
      pdfPath: data['pdf_path'] as String?,
      notes: data['notes'] as dynamic,
      price: data['price'] as String?,
      vat: data['vat'] as String?,
      totalPrice: data['total_price'] as String?,
      createdAt:
          data['created_at'] == null
              ? null
              : DateTime.parse(data['created_at'] as String),
      updatedAt:
          data['updated_at'] == null
              ? null
              : DateTime.parse(data['updated_at'] as String),
      isFixed: data['is_fixed'] as bool?,
      isSpareChanged: data['is_spare_changed'] as bool?,
      contract:
          data['contract'] == null
              ? null
              : Contract.fromMap(data['contract'] as Map<String, dynamic>),
      technician:
          data['technician'] == null
              ? null
              : Technician.fromMap(data['technician'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'contract_id': contractId,
    'technician_id': technicianId,
    'report_type': reportType,
    'questions_answers': questionsAnswers?.map((e) => e.toMap()).toList(),
    'image': image,
    'pdf_path': pdfPath,
    'notes': notes,
    'price': price,
    'vat': vat,
    'total_price': totalPrice,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'is_fixed': isFixed,
    'is_spare_changed': isSpareChanged,
    'contract': contract?.toMap(),
    'technician': technician?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TechnicalReportModel].
  factory TechnicalReportModel.fromJson(String data) {
    return TechnicalReportModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [TechnicalReportModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
