import 'dart:convert';

class QuestionRequest {
  String? question;
  String? type;
  int? answerType;
  int? status;

  QuestionRequest({this.question, this.type, this.answerType, this.status});

  @override
  String toString() {
    return 'QuestionRequest(question: $question, type: $type, answerType: $answerType, status: $status)';
  }

  factory QuestionRequest.fromMap(Map<String, dynamic> data) {
    return QuestionRequest(
      question: data['question'] as String?,
      type: data['type'] as String?,
      answerType: data['answer_type'] as int?,
      status: data['status'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'question': question,
    'type': type,
    'answer_type': answerType,
    'status': status,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionRequest].
  factory QuestionRequest.fromJson(String data) {
    return QuestionRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionRequest] to a JSON string.
  String toJson() => json.encode(toMap());
}
