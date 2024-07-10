import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

class QuizGeneratorView extends ConsumerStatefulWidget {
  const QuizGeneratorView({super.key});

  @override
  ConsumerState<QuizGeneratorView> createState() => _QuizGeneratorViewState();
}

class _QuizGeneratorViewState extends ConsumerState<QuizGeneratorView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final String prompt = ref.watch(promptQuizProvider);
    _controller.text = prompt;

    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      borderRadius: BorderRadius.circular(40.0),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Message',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      contentPadding: const EdgeInsets.all(20.0),
      // filled: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(children: [
                TextFormField(
                  controller: _controller,
                  decoration: inputDecoration,
                  maxLines: null,
                ),
                Positioned(
                  right: -10,
                  top: -10,
                  child: IconButton(
                    onPressed: () {
                      ref.read(promptQuizProvider.notifier).setPrompt('');
                    },
                    icon: const Icon(Icons.cancel_outlined),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide()),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                )
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                    onPressed: () {
                      _menuQuizGenerator(context);
                    },
                    icon: const Icon(Icons.settings_outlined),
                    label: const Text('Quiz Settings')),
                OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text('Generate Quiz')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _menuQuizGenerator(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Questions Type:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Consumer(builder: (context, ref, child) {
                  final quiz = ref.watch(quizParamsProvider);

                  return Center(
                    child: SegmentedButton(
                        multiSelectionEnabled: true,
                        showSelectedIcon: false,
                        segments: QuizType.values.map((e) {
                          return ButtonSegment<QuizType>(
                              value: e, label: Text(e.toString()));
                        }).toList(),
                        selected: quiz.type,
                        onSelectionChanged: (value) {
                          ref
                              .read(quizParamsProvider.notifier)
                              .setParams(quiz.copyWith());
                        }),
                  );
                }),
                const SizedBox(height: 10),
                const Text(
                  'Quiz Language:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        });
  }
}
