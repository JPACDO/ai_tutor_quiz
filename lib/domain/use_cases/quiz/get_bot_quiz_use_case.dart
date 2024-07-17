import '../../entities/entities.dart';
import '../../repositories/quiz/quiz_repository.dart';
import '../base_usecase.dart';

/// Use case to get a bot quiz based on a prompt and a quiz.
///
/// This class encapsulates the logic to get a bot quiz based on a prompt and a quiz.
///
/// It takes a [data] as input, which represents the prompt for the quiz.
/// The [quiz] parameter is the specific quiz to be retrieved.
///
/// It returns a [Future] that completes with a list of [Question] objects.
class GetBotQuizUseCase extends BaseUseCase<List<Question>, String> {
  final QuizRepository _quizRepository;
  GetBotQuizUseCase(this._quizRepository);

  /// [data] = prompt
  @override
  Future<List<Question>> call({required String data, Quiz? quiz}) async {
    if (quiz == null) throw Exception('Quiz null');

    return await _quizRepository.getBotQuiz(prompt: data, quiz: quiz);
  }
}
