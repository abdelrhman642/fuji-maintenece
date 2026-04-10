import 'dart:convert';

class QuestionResponseModel {
  int? id;
  String? question;
  String? type;
  bool? answerType;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuestionResponseModel({
    this.id,
    this.question,
    this.type,
    this.answerType,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'QuestionResponseModel(id: $id, question: $question, type: $type, answerType: $answerType, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory QuestionResponseModel.fromMap(Map<String, dynamic> data) {
    return QuestionResponseModel(
      id: data['id'] as int?,
      question: data['question'] as String?,
      type: data['type'] as String?,
      answerType: data['answer_type'] as bool?,
      status: data['status'] as bool?,
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
    'question': question,
    'type': type,
    'answer_type': answerType,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionResponseModel].
  factory QuestionResponseModel.fromJson(String data) {
    return QuestionResponseModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
