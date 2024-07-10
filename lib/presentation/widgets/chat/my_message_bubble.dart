import 'dart:io';

import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';
import 'package:flutter/material.dart';

class MyMessageBubble extends StatelessWidget {
  final Message message;
  final bool isLast;
  final Function()? onResent;

  const MyMessageBubble(
      {super.key, required this.message, this.isLast = false, this.onResent});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        (message.imgUrl != null) ? _ImageBubble(message.imgUrl!) : Container(),
        Container(
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              // color: colors.primary.withAlpha(30),
              border: Border.all(color: colors.primary),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SelectableText(
              message.content,
            ),
          ),
        ),
        isLast
            ? OutlinedButton(
                onPressed: onResent, child: const Icon(Icons.refresh_sharp))
            : Container(),
        const SizedBox(height: 5),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Image.file(
                File(imageUrl),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      },
      child: Image.file(
        File(imageUrl),
        width: 150,
        height: 150,
      ),
    );
  }
}
