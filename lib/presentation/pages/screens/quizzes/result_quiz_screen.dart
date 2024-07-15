import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class ResultQuizScreen extends ConsumerWidget {
  const ResultQuizScreen({super.key});

  static const name = 'resume-quiz';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.read(quizPProvider);

    final results =
        ref.read(quizUserResponseProvider.notifier).calculateResult(quiz);
    final List<Widget> questionWidget = interactiveQuestions(
      instaFeed: true,
      quiz: quiz,
      showNextButton: false,
      showAnswers: true,
      userResponse: ref.read(quizUserResponseProvider),
      onPressAnswer: (index, response) {},
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            ref.invalidate(quizUserResponseProvider);
            context.go('/home/1');
          },
        ),
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
