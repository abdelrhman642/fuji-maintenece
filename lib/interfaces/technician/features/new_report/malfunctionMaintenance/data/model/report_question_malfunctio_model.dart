// ignore_for_file: prefer_collection_literals, unnecessary_new

class ReportQuestionMalfunctioModel {
  int? id;
  String? question;
  String? type;
  bool? answerType;

  ReportQuestionMalfunctioModel({
    this.id,
    this.question,
    this.type,
    this.answerType,
  });

  ReportQuestionMalfunctioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    type = json['type'];
    answerType = json['answer_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['type'] = type;
    data['answer_type'] = answerType;
    return data;
  }
}
