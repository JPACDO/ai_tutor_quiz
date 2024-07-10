import 'package:ai_tutor_quiz/domain/entities/quiz/question.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';

class QuizRepositoryImpl implements QuizRepository {
  final GeminiChatDatasource _geminiChatDatasource;

  QuizRepositoryImpl(this._geminiChatDatasource);

  @override
  Future<bool> deleteQuiz({required String id}) {
    // TODO: implement deleteQuiz
    throw UnimplementedError();
  }

  @override
  Future<List<Question>> getBotQuiz({required String prompt}) async {
    return await _geminiChatDatasource.getQuizFromBot(prompt: prompt);
  }

  @override
  Future<bool> saveQuiz({required Question quiz}) {
    // TODO: implement saveQuiz
    throw UnimplementedError();
  }
}
