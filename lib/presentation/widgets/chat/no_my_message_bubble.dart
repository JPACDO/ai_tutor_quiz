import 'dart:io';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class NoMyMessageBubble extends StatelessWidget {
  final Message message;

  const NoMyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              color: colors.secondary.withAlpha(30),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Markdown(
              data: message.content,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              selectable: true,
            ),
            // SelectableText(
            //   message.content,
            // ),
          ),
        ),
        const SizedBox(height: 5),
        (message.imgUrl != null) ? _ImageBubble(message.imgUrl!) : Container(),
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
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.file(
        File(imageUrl),
        width: size.width * 0.7,
        height: 150,
      ),
      //  Image.network(
      //   imageUrl,
      //   width: size.width * 0.7,
      //   height: 150,
      //   fit: BoxFit.cover,
      //   loadingBuilder: (context, child, loadingProgress) {
      //     if (loadingProgress == null) return child;

      //     return Container(
      //       width: size.width * 0.7,
      //       height: 150,
      //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //       child: const Text('...imagen'),
      //     );
      //   },
      // )
    );
  }
}
