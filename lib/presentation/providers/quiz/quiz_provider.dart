import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/use_cases/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_tutor_quiz/infrastructure/repositories/quiz/quiz_repository_impl.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

part 'quiz_provider.g.dart';

@riverpod
QuizRepositoryImpl quizRepository(QuizRepositoryRef ref) {
  final geminiChatDatasource = ref.read(geminiChatDatasourceProvider);

  return QuizRepositoryImpl(geminiChatDatasource);
}

@riverpod
GetBotQuizUseCase getBotQuiz(GetBotQuizRef ref) {
  final quizRepository = ref.read(quizRepositoryProvider);
  return GetBotQuizUseCase(quizRepository);
}

@riverpod
class QuizP extends _$QuizP {
  @override
  List<Question> build() {
    return [];
  }

  Future<void> getQuiz({required String prompt}) async {
    final quiz = ref.read(quizParamsProvider);
    final quizList =
        await ref.read(getBotQuizProvider)(prompt: prompt, quiz: quiz);

    state = [...quizList];
  }
}

@Riverpod(keepAlive: true)
class PromptQuiz extends _$PromptQuiz {
  @override
  String build() {
    return '';
  }

  void setPrompt(String prompt) {
    state = prompt;
  }
}

@Riverpod(keepAlive: true)
class QuizParams extends _$QuizParams {
  @override
  Quiz build() {
    return const Quiz(
      type: {QuizType.multipleChoice},
      questions: [],
      language: 'From text',
      difficulty: 'medium',
      numberOfQuestions: 5,
      instaFeedback: false,
    );
  }

  void setParams(Quiz quiz) {
    print(quiz);
    state = quiz;
  }
}
