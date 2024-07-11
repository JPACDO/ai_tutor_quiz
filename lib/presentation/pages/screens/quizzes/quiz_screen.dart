import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  static const name = 'quiz-screen';

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();
    final prompt = ref.read(promptQuizProvider);
    ref.read(quizPProvider.notifier).getQuiz(prompt: prompt);
  }

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = ref.watch(quizPProvider);

    return Scaffold(
      appBar: AppBar(),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final alternatives =
                    questions[index].alternatives.map((e) => Text(e)).toList();
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey.shade300,
                  child: Column(
                    children: [
                      Text(questions[index].question),
                      ...alternatives,
                      Text(questions[index].correctAnswerIndex.toString()),
                      Text(questions[index].type.toString()),
                    ],
                  ),
                );
              }),
    );
  }
}
