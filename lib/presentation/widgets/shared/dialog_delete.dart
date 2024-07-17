import 'package:flutter/material.dart';

/// Shows a dialog to confirm the deletion of an item.
///
/// This function will display a dialog with a title, a message and two buttons.
/// The first button is used to cancel the deletion, the second button is used to confirm the deletion.
/// When the confirm button is pressed, the [onSubmit] function is called.
///
/// The [context] parameter is the build context of the widget that called this function.
/// The [name] parameter is text that represents the name of the item that will be deleted.
/// The [onSubmit] parameter is the function that will be called when the deletion is confirmed.
Future<void> dialogDelete({
  required BuildContext context,
  required String name,
  required VoidCallback onSubmit,
}) {
  // Show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // Create the content of the dialog
      return AlertDialog(
        title: const Text('Delete'), // Set the title of the dialog
        content: Text(
          'Are you sure you want to delete $name?', // Set the message of the dialog
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          // Add the cancel button
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(), // Close the dialog when pressed
            child: const Text('Cancel'),
          ),
          // Add the delete button
          TextButton(
            onPressed: () {
              // Call the onSubmit function when the delete button is pressed
              onSubmit();
              // Close the dialog when the delete button is pressed
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
