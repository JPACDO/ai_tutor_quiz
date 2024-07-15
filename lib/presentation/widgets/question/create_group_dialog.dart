import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

Future<void> dialogCreateGroup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
            title: Text('Add new list'), content: CreateGroupDialog());
      });
}

class CreateGroupDialog extends ConsumerStatefulWidget {
  const CreateGroupDialog({super.key});

  @override
  ConsumerState<CreateGroupDialog> createState() => _NewGroupDialogState();
}

class _NewGroupDialogState extends ConsumerState<CreateGroupDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'List name',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) return;

                    ref
                        .read(groupQuestionProvider.notifier)
                        .createGroupQuestion(
                          GroupQuestions(
                            questions: [],
                            name: _controller.text,
                          ),
                        );
                    context.pop();
                  },
                  child: const Text('SAVE')),
            ],
          ),
        ],
      ),
    );
  }
}
