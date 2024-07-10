import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class Question {
  String question;
  List<String> alternatives;
  int correctAnswerIndex;
  QuizType type;

  Question(
      {required this.question,
      required this.alternatives,
      required this.correctAnswerIndex,
      required this.type});
}
