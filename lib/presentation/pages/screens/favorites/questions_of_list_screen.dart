import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class QuestionsOfList extends ConsumerStatefulWidget {
  const QuestionsOfList({super.key, required this.group});
  final GroupQuestions group;

  static const name = 'questions_of_list';

  @override
  ConsumerState<QuestionsOfList> createState() => _QuestionsOfListState();
}

class _QuestionsOfListState extends ConsumerState<QuestionsOfList> {
  @override
  Widget build(BuildContext context) {
    final questionsWidget = interactiveQuestions(
      quiz: widget.group.questions,
      showNextButton: false,
      showAnswers: true,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      instaFeed: true,
      onPressAnswer: (index, response) {},
      userResponse: [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(quizUserResponseProvider.notifier).reset();
              context.pushNamed(TakeQuizSaved.name, extra: widget.group);
            },
            icon: const Row(
              children: [
                Text('Take Quiz'),
                Icon(Icons.restart_alt_outlined),
              ],
            ),
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
                  onPressed: () {
                    dialogDelete(
                        context: context,
                        name: '',
                        onSubmit: () {
                          ref
                              .read(groupQuestionProvider.notifier)
                              .removeQuestion(
                                  groupId: widget.group.id!,
                                  questionId:
                                      widget.group.questions[index].id!);
                          widget.group.questions.removeWhere((element) =>
                              element.id == widget.group.questions[index].id);
                          setState(() {});
                        });
                  },
                  icon: const Icon(Icons.delete_outline)),
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
