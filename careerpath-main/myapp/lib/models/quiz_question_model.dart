// lib/models/quiz_question_model.dart

class QuizQuestionModel {
  final String id;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String domainTag;

  QuizQuestionModel({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.domainTag,
  });

  factory QuizQuestionModel.fromMap(String id, Map<String, dynamic> map) {
    return QuizQuestionModel(
      id: id,
      questionText: map['question_text'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswer: map['correct_answer'] ?? '',
      domainTag: map['domain_tag'] ?? '',
    );
  }
}