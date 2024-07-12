import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  static const name = 'quiz-screen';

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prompt = ref.read(promptQuizProvider);

    return FutureBuilder(
        future: ref.read(quizPProvider.notifier).getQuiz(prompt: prompt),
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

            final List<Widget> questionWidget = [];

            for (var question in questions) {
              questionWidget.add(InteractiveQuestion(
                  index: questions.indexOf(question),
                  question: question,
                  onNextPage: () {
                    if (question == questions.last) {
                      context.pushNamed(ResultQuizScreen.name);
                      return;
                    }
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                  showNextButton: true));
            }
            body = questions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PageView(
                    // physics: const NeverScrollableScrollPhysics(),
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
