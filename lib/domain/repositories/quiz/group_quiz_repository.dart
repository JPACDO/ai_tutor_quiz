import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class GroupQuizRepository {
  Future<List<Quiz>> getGroupQuiz();
}
