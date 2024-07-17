import 'dart:io';

import 'package:flutter/material.dart';

/// Shows an image viewer dialog with an image file.
///
/// This function shows a dialog with an interactive image viewer that allows
/// the user to zoom in and out of the image. The dialog also includes a close
/// button that allows the user to dismiss the dialog.
///
/// The [context] parameter is the build context of the widget that is calling
/// this function.
///
/// The [imageUrl] parameter is the URL of the image file to display in the
/// dialog.
///
/// This function returns a [Future] that completes with the result of the
/// dialog being dismissed.
Future<void> showImagerViewer(BuildContext context, String imageUrl) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: InteractiveViewer(
        // Disable panning
        panEnabled: false,
        boundaryMargin: const EdgeInsets.all(100),
        // Set the minimum and maximum scale
        minScale: 0.5,
        maxScale: 2,
        // Set the child of the InteractiveViewer to be an Image file
        child: Image.file(
          File(imageUrl),
        ),
      ),
      actions: [
        // Add a close button to the dialog
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
