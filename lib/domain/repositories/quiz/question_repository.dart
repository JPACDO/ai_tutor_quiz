import '../../entities/entities.dart';

abstract class QuestionRepository {
  Future<List<Question>> getQuestionsFromBot(
      {required String prompt, required Quiz quiz});
}
