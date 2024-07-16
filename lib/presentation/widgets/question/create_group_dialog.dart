import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> dialogCreateNew(BuildContext context, Function(String) onSubmit) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add new'),
            content: CreateGroupDialog(
              onSubmit: onSubmit,
            ));
      });
}

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({super.key, required this.onSubmit});

  final Function(String) onSubmit;

  @override
  State<CreateGroupDialog> createState() => _NewGroupDialogState();
}

class _NewGroupDialogState extends State<CreateGroupDialog> {
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
              labelText: 'Name',
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
                    widget.onSubmit(_controller.text);

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
