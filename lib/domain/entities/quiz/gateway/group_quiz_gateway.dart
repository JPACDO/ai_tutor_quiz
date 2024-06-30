import 'package:ai_tutor_quiz/domain/entities/quiz/group_quiz.dart';

abstract class GroupQuizGateway {
  Future<GroupQuiz> getGroupQuiz();
}
