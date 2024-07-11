import '../../entities/entities.dart';
import '../../repositories/quiz/quiz_repository.dart';
import '../base_usecase.dart';

class GetBotQuizUseCase extends BaseUseCase<List<Question>, String> {
  final QuizRepository _quizRepository;
  GetBotQuizUseCase(this._quizRepository);

  /// [prompt] = prompt
  @override
  Future<List<Question>> call({required String prompt, Quiz? quiz}) async {
    if (quiz == null) throw Exception('Quiz null');

    return await _quizRepository.getBotQuiz(prompt: prompt, quiz: quiz);
  }
}
