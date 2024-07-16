import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> dialogCreateNew(
    {required BuildContext context,
    required String title,
    String? fieldText,
    required Function(String) onSubmit}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title),
            content: CreateGroupDialog(
              onSubmit: onSubmit,
              text: fieldText,
            ));
      });
}

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({super.key, required this.onSubmit, this.text});
  final String? text;
  final Function(String) onSubmit;

  @override
  State<CreateGroupDialog> createState() => _NewGroupDialogState();
}

class _NewGroupDialogState extends State<CreateGroupDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.text ?? '';
  }

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
