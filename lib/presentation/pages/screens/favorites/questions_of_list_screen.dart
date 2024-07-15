import 'package:flutter/material.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class QuestionsOfList extends StatelessWidget {
  const QuestionsOfList({super.key, required this.gorup});
  final GroupQuestions gorup;

  static const name = 'questions_of_list';

  @override
  Widget build(BuildContext context) {
    final questionsWidget = interactiveQuestions(
      quiz: gorup.questions,
      showNextButton: false,
      showAnswers: true,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      instaFeed: true,
      onPressAnswer: (index, response) {},
      userResponse: [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(gorup.name),
      ),
      body: ListView.builder(
        itemCount: questionsWidget.length,
        itemBuilder: (context, index) {
          return questionsWidget[index];
        },
      ),
    );
  }
}
