import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';

class QuiestionRepositoryImpl implements QuestionRepository {
  final GeminiChatDatasource _geminiChatDatasource;

  QuiestionRepositoryImpl(this._geminiChatDatasource);

  @override
  Future<List<Question>> getQuestionsFromBot(
      {required String prompt, required Quiz quiz}) async {
    return await _geminiChatDatasource.getQuestionsFromBot(
        prompt: prompt, quiz: quiz);
  }
}
