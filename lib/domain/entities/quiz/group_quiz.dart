import 'package:ai_tutor_quiz/domain/entities/quiz/question.dart';

class GroupQuiz {
  final String name;
  final String? description;
  final List<Question> quizzes;

  GroupQuiz({required this.name, this.description, required this.quizzes});
}
