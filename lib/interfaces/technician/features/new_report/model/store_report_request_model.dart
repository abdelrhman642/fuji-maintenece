class StoreReportRequestModel {
  int? contractId;
  String? reportType;
  List<QuestionsAnswersRequestModel>? questionsAnswers;
  double? cost;
  String? notes;
  String? image;
  num? price;

  StoreReportRequestModel({
    this.contractId,
    this.reportType,
    this.questionsAnswers,
    this.price,
  });

  StoreReportRequestModel.fromJson(Map<String, dynamic> json) {
    contractId = json['contract_id'];
    reportType = json['report_type'];
    price = json['price'];
    if (json['questions_answers'] != null) {
      questionsAnswers = <QuestionsAnswersRequestModel>[];
      json['questions_answers'].forEach((v) {
        questionsAnswers!.add(QuestionsAnswersRequestModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contract_id'] = contractId;
    data['report_type'] = reportType;
    data['price'] = price;
    if (questionsAnswers != null) {
      data['questions_answers'] =
          questionsAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsAnswersRequestModel {
  int? questionId;
  String? question;
  int? answerType;
  String? answer;

  QuestionsAnswersRequestModel({
    this.questionId,
    this.question,
    this.answerType,
    this.answer,
  });

  QuestionsAnswersRequestModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    answerType = json['answer_type'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question'] = question;
    data['answer_type'] = answerType;
    data['answer'] = answer;
    return data;
  }
}
