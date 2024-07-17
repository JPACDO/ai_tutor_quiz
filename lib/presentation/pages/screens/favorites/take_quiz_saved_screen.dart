import 'package:flutter/material.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class TakeQuizSaved extends StatelessWidget {
  const TakeQuizSaved({super.key, required this.quiz});

  final GroupQuestions quiz;

  static const name = 'take-saved-quiz';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${quiz.name}'),
      ),
      body: TakeQuiz(
        questions: quiz.questions,
        instaFeed: false,
      ),
    );
  }
}
