import 'package:ai_tutor_quiz/domain/entities/quiz/quiz.dart';

class GroupQuiz {
  final String name;
  final String? description;
  final List<Quiz> quizzes;

  GroupQuiz({required this.name, this.description, required this.quizzes});
}
