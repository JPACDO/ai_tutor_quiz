import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';

class QuizLoadScreen extends ConsumerStatefulWidget {
  const QuizLoadScreen({super.key});

  static const name = 'quiz-screen';

  @override
  ConsumerState<QuizLoadScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizLoadScreen> {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.read(quizPProvider.notifier).getQuiz(),
        builder: (context, snapchot) {
          Widget body = const SizedBox();
          if (snapchot.connectionState == ConnectionState.waiting) {
            body = const Center(child: CircularProgressIndicator());
          }

          if (snapchot.hasError) {
            body = Center(
                child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: SelectableText(
                  '${snapchot.error.toString()}. Rephase your request'),
            ));
          }

          if (snapchot.hasData) {
            final List<Question> questions = snapchot.data!;

            final List<Widget> questionWidget = interactiveQuestions(
              instaFeed: ref.read(quizParamsProvider).instaFeedback,
              quiz: questions,
              showNextButton: true,
              showAnswers: false,
              onNextPage: (Question question) {
                if (question == questions.last) {
                  context.pushReplacementNamed(ResultQuizScreen.name);
                  return;
                }
                pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              onPressAnswer: (index, response) {
                ref
                    .read(quizUserResponseProvider.notifier)
                    .setResponse(index: index, response: response);
              },
              onSave: (question) {
                return showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SaveQuestionWidget(
                        question: question,
                      );
                    });
              },
            );

            body = questions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    // index: pageIndex,
                    children: questionWidget,
                  );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz'),
            ),
            body: body,
          );
        });
  }
}
