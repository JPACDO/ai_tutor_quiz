import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      instaFeed: true,
      onPressAnswer: (index, response) {},
      userResponse: [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(gorup.name),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(TakeQuizSaved.name, extra: gorup);
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: questionsWidget.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              questionsWidget[index],
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.delete_outline)),
              const Divider(
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
