import 'package:flutter/material.dart';

Future<void> dialogDelete(
    {required BuildContext context,
    required String name,
    required VoidCallback onSubmit}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Delete'),
            content: Text(
              'Are you sure you want to delete $name?',
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    onSubmit();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete')),
            ]);
      });
}
