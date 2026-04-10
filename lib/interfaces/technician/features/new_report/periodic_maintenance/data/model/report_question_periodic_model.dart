class ReportQuestionPeriodicModel {
  int? id;
  String? question;
  String? type;
  bool? answerType;

  ReportQuestionPeriodicModel({
    this.id,
    this.question,
    this.type,
    this.answerType,
  });

  ReportQuestionPeriodicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    type = json['type'];
    answerType = json['answer_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['type'] = type;
    data['answer_type'] = answerType;
    return data;
  }
}
