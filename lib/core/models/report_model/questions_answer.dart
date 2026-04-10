import 'dart:convert';

class QuestionsAnswer {
  int? questionId;
  String? question;
  int? answerType;
  String? answer;

  QuestionsAnswer({
    this.questionId,
    this.question,
    this.answerType,
    this.answer,
  });

  @override
  String toString() {
    return 'QuestionsAnswer(questionId: $questionId, question: $question, answerType: $answerType, answer: $answer)';
  }

  factory QuestionsAnswer.fromMap(Map<String, dynamic> data) {
    return QuestionsAnswer(
      questionId: data['question_id'] as int?,
      question: data['question'] as String?,
      answerType: data['answer_type'] as int?,
      answer: data['answer'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'question_id': questionId,
    'question': question,
    'answer_type': answerType,
    'answer': answer,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionsAnswer].
  factory QuestionsAnswer.fromJson(String data) {
    return QuestionsAnswer.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionsAnswer] to a JSON string.
  String toJson() => json.encode(toMap());
}
