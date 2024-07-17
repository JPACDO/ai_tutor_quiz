import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/config/constants/values.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class SaveQuestionWidget extends ConsumerStatefulWidget {
  const SaveQuestionWidget({super.key, required this.question});

  final Question question;

  @override
  ConsumerState<SaveQuestionWidget> createState() => _SaveQuestionWidgetState();
}

class _SaveQuestionWidgetState extends ConsumerState<SaveQuestionWidget> {
  @override
  void initState() {
    super.initState();
    ref.read(groupQuestionProvider.notifier).getAllGroup(userId: user.id);
  }

  @override
  Widget build(BuildContext context) {
    final groupQuestions = ref.watch(groupQuestionProvider);

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Add new list'),
          onTap: () => dialogCreateNew(
              context: context,
              title: 'Create new list',
              onSubmit: (name) {
                ref.read(groupQuestionProvider.notifier).createGroup(
                      GroupQuestions(
                          questions: [], name: name, userId: user.id),
                    );
              }),
        ),
        Flexible(
          child: ListView.builder(
              itemCount: groupQuestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.list),
                  title: Text(groupQuestions[index].name),
                  onTap: () async {
                    final result = await ref
                        .read(groupQuestionProvider.notifier)
                        .insertQuestion(
                            question: widget.question,
                            groupId: groupQuestions[index].id!);

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(result
                          ? 'Question saved in ${groupQuestions[index].name}'
                          : 'Error saving question'),
                      backgroundColor: result ? Colors.green : Colors.red,
                    ));
                    Navigator.of(context).pop();
                  },
                );
              }),
        ),
      ],
    );
  }
}
