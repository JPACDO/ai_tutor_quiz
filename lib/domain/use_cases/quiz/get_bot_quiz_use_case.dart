import '../../entities/entities.dart';
import '../../repositories/quiz/quiz_repository.dart';
import '../base_usecase.dart';

class GetBotQuizUseCase extends BaseUseCase<Quiz?, String> {
  final QuizRepository _quizRepository;
  GetBotQuizUseCase(this._quizRepository);

  /// [params] = prompt
  @override
  Future<Quiz?> call({String? params}) async {
    if (params == null) return Future.value(null);
    return await _quizRepository.getBotQuiz(prompt: params);
  }
}
