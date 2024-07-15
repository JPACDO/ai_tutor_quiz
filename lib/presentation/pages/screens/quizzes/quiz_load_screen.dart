import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

class QuizLoadScreen extends ConsumerWidget {
  const QuizLoadScreen({super.key});

  static const name = 'quiz-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

            body = TakeQuiz(
              questions: questions,
              instaFeed: ref.read(quizParamsProvider).instaFeedback,
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
