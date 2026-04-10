import 'dart:convert';

import 'contract.dart';
import 'questions_answer.dart';
import 'technician.dart';

class ReportModel {
  int? id;
  int? contractId;
  int? technicianId;
  String? reportType;
  List<QuestionsAnswer>? questionsAnswers;
  dynamic image;
  String? pdfPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  Contract? contract;
  Technician? technician;

  ReportModel({
    this.id,
    this.contractId,
    this.technicianId,
    this.reportType,
    this.questionsAnswers,
    this.image,
    this.pdfPath,
    this.createdAt,
    this.updatedAt,
    this.contract,
    this.technician,
  });

  @override
  String toString() {
    return 'ReportModel(id: $id, contractId: $contractId, technicianId: $technicianId, reportType: $reportType, questionsAnswers: $questionsAnswers, image: $image, pdfPath: $pdfPath, createdAt: $createdAt, updatedAt: $updatedAt, contract: $contract, technician: $technician)';
  }

  factory ReportModel.fromMap(Map<String, dynamic> data) => ReportModel(
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
    createdAt:
        data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
    updatedAt:
        data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
    contract:
        data['contract'] == null
            ? null
            : Contract.fromMap(data['contract'] as Map<String, dynamic>),
    technician:
        data['technician'] == null
            ? null
            : Technician.fromMap(data['technician'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'contract_id': contractId,
    'technician_id': technicianId,
    'report_type': reportType,
    'questions_answers': questionsAnswers?.map((e) => e.toMap()).toList(),
    'image': image,
    'pdf_path': pdfPath,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'contract': contract?.toMap(),
    'technician': technician?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ReportModel].
  factory ReportModel.fromJson(String data) {
    return ReportModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ReportModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
