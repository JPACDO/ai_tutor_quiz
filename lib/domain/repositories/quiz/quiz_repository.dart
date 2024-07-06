import '../../entities/entities.dart';

abstract class QuizRepository {
  Future<Quiz?> getBotQuiz({required String prompt});
  Future<List<Quiz>> getAllQuiz({required String topicId});
  Future<bool> saveQuiz({required Quiz quiz});
  Future<bool> deleteQuiz({String id});
}
