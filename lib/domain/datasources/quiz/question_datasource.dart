import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class QuestionDatasource {
  Future<List<Question>> getQuestionsFromBot(
      {required String prompt, required Quiz quiz});
}
