import 'package:ai_tutor_quiz/presentation/providers/quiz/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:markdown_widget/markdown_widget.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/home_screen.dart';

class NoMyMessageBubble extends ConsumerWidget {
  final Message message;

  const NoMyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              // color: colors.secondary.withAlpha(30),
              border: Border.all(color: colors.secondary),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Markdown(
              data: message.content,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              selectable: true,
              onTapLink: (text, href, title) async {
                // print('text: $text, href: $href, title: $title');
                if (!await launchUrl(Uri.parse(href!))) {
                  throw Exception('Could not launch $href');
                }
              }),
        ),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(promptQuizProvider.notifier).setPrompt(message.content);
            context.pushNamed(HomeScreen.name, pathParameters: {'page': '1'});
          },
          icon: const Icon(
            Icons.rocket_launch,
          ),
          label: const Text('Generate Quiz'),
        ),
        const SizedBox(height: 5),
        const SizedBox(height: 10),
      ],
    );
  }
}
