import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class GroupQuizDatasource {
  Future<List<Question>> getGroupQuiz();
}
