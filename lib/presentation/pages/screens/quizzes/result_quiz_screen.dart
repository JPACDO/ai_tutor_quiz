import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class ResultQuizScreen extends ConsumerWidget {
  const ResultQuizScreen({super.key});

  static const name = 'resume-quiz';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.read(quizPProvider);
    final results =
        ref.read(quizUserResponseProvider.notifier).calculateResult(quiz);
    final List<Widget> questionWidget = [];

    for (var question in quiz) {
      questionWidget.add(InteractiveQuestion(
        index: quiz.indexOf(question),
        question: question,
        onNextPage: () {},
        showNextButton: false,
        showAnswers: true,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Quiz'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              '${results['correct']}/${results['total']}',
              style: const TextStyle(fontSize: 50),
            ),
            (results['open']! > 0)
                ? Text(
                    textAlign: TextAlign.center,
                    '(Open Answer: ${results['open']})',
                    style: const TextStyle(fontSize: 20),
                  )
                : Container(),
            ...questionWidget,
          ],
        ),
      ),
    );
  }
}
