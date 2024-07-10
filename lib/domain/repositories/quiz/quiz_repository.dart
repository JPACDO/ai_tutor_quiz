import '../../entities/entities.dart';

abstract class QuizRepository {
  Future<List<Question>> getBotQuiz({required String prompt});
  Future<bool> saveQuiz({required Question quiz});
  Future<bool> deleteQuiz({required String id});
}
