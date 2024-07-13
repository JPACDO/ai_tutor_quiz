import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/use_cases/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_tutor_quiz/infrastructure/repositories/repositories.dart';
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

@Riverpod(keepAlive: true)
class QuizP extends _$QuizP {
  @override
  List<Question> build() {
    return [];
  }

  Future<List<Question>> getQuiz({required String prompt}) async {
    final quiz = ref.read(quizParamsProvider);
    try {
      final quizList =
          await ref.read(getBotQuizProvider)(prompt: prompt, quiz: quiz);

      state = [...quizList];
      ref.read(quizUserResponseProvider.notifier).reset();

      return state;
    } catch (e) {
      rethrow;
    }
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

@Riverpod(keepAlive: true)
class QuizUserResponse extends _$QuizUserResponse {
  @override
  List<int?> build() {
    return [];
  }

  void setResponse({required int index, required int response}) {
    if (index >= state.length) {
      state.addAll(List.filled(index - state.length + 1, null));
    }

    // Añade el valor al índice especificado
    state[index] = response;
    state = [...state];
    print(state);
  }

  void reset() {
    state = [];
  }

  Map<String, int> calculateResult(List<Question> quiz) {
    // final quiz = ref.read(quizPProvider);

    final results = {
      'correct': 0,
      'total': 0,
      'open': 0,
    };

    results['total'] = state.length;

    for (var i = 0; i < state.length; i++) {
      if (quiz[i].type == QuizType.openAnswer) {
        results['open'] = results['open']! + 1;
        results['correct'] = results['correct']! + 1;
        continue;
      }

      if (quiz[i].correctAnswerIndex == state[i]) {
        results['correct'] = results['correct']! + 1;
        continue;
      }
    }

    return results;
  }
}
