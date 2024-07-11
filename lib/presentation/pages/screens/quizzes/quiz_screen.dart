import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

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
  void initState() {
    super.initState();
    // final prompt = ref.read(promptQuizProvider);
    // ref.read(quizPProvider.notifier).getQuiz(prompt: prompt);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prompt = ref.read(promptQuizProvider);

    // final List<Question> questions = ref.watch(quizPProvider);

    // final List<Widget> questionWidget = [];

    // for (var question in questions) {
    //   questionWidget.add(_InteractiveQuestion(
    //       index: questions.indexOf(question),
    //       question: question,
    //       onNextPage: () {}));
    // }

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
              questionWidget.add(_InteractiveQuestion(
                  index: questions.indexOf(question),
                  question: question,
                  onNextPage: () {}));
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

class _InteractiveQuestion extends ConsumerWidget {
  const _InteractiveQuestion(
      {required this.index, required this.question, required this.onNextPage});
  final int index;
  final Question question;
  final Function onNextPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final instaFeed = ref.read(quizParamsProvider).instaFeedback;
    final userResponse = ref.watch(quizUserResponseProvider);

    final int? selected =
        (userResponse.length > index) ? userResponse[index] : null;

    final List<Widget> alternatives = [];
    for (var alternative in question.alternatives) {
      int indexAlternative = question.alternatives.indexOf(alternative);

      alternatives.add(
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20.0),
              color: selected == indexAlternative
                  ? Colors.amber
                  : Colors.transparent,
            ),
            child: Text(alternative),
          ),
          onTap: () {
            ref
                .read(quizUserResponseProvider.notifier)
                .setResponse(index: index, response: indexAlternative);
          },
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey.shade300,
      child: Column(
        children: [
          Text(question.question),
          ...alternatives,
          Text(question.correctAnswerIndex.toString()),
          Text(question.type.toString()),
        ],
      ),
    );
  }
}
