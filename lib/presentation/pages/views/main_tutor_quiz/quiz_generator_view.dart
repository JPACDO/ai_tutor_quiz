import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
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
  Widget build(BuildContext context) {
    final colorBorder = Theme.of(context).colorScheme.secondary;

    final String prompt = ref.read(promptQuizProvider);
    _controller.text = prompt;

    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorBorder),
      borderRadius: BorderRadius.circular(40.0),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Content or topic',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      contentPadding: const EdgeInsets.all(20.0),
      // filled: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Generator'),
      ),
      endDrawer: const DrawerMenu(),
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
                  onChanged: (value) {
                    ref.read(promptQuizProvider.notifier).setPrompt(value);
                  },
                ),
                Positioned(
                  right: -10,
                  top: -11,
                  child: IconButton(
                    onPressed: () {
                      _controller.clear();
                      ref.read(promptQuizProvider.notifier).setPrompt('');
                    },
                    icon: const Icon(Icons.cancel_outlined),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: colorBorder)),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.background),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(height: 20),
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
                    onPressed: () async {
                      final String prompt = await ref.read(promptQuizProvider);
                      if (prompt.trim().isEmpty) {
                        if (!context.mounted) return;
                        _noContentDialog(context);
                        return;
                      }

                      if (!context.mounted) return;

                      context.pushNamed(QuizLoadScreen.name);
                    },
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text('Generate Quiz')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _noContentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please enter a content'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'))
            ],
          );
        });
  }

  Future<dynamic> _menuQuizGenerator(BuildContext context) {
    final colorBg = Theme.of(context).colorScheme.background;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: colorBg,
            surfaceTintColor: colorBg,
            content: const _MenuDialog(),
            actions: [
              TextButton(
                  onPressed: () => context.pop(), child: const Text('CLOSE'))
            ],
          );
        });
  }
}

class _MenuDialog extends ConsumerStatefulWidget {
  const _MenuDialog();

  @override
  ConsumerState<_MenuDialog> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends ConsumerState<_MenuDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizParamsProvider);
    _controller.text = quiz.numberOfQuestions.toString();
    const int maxNumberOfQuestions = 5;

    return SingleChildScrollView(
      child: SizedBox(
        // height: 300,
        width: double.infinity,
        // padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Questions Type:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: SegmentedButton(
                  multiSelectionEnabled: true,
                  showSelectedIcon: false,
                  segments: QuizType.values.map((e) {
                    return ButtonSegment<QuizType>(
                        value: e,
                        label: Text(
                          e.toString(),
                          textAlign: TextAlign.center,
                        ));
                  }).toList(),
                  selected: quiz.type,
                  onSelectionChanged: (value) {
                    ref.read(quizParamsProvider.notifier).setParams(
                          quiz.copyWith(type: value),
                        );
                  }),
            ),
            // const SizedBox(height: 10),
            // const Text(
            //   'Quiz Language:',
            //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),
            // TextFormField(),
            const SizedBox(height: 20),
            const Text(
              'Number of Questions ( Max $maxNumberOfQuestions ):',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 150.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Number of Questions',
                  ),
                  onChanged: (value) {
                    if (value.trim().isEmpty) return;

                    if (int.tryParse(value) == null) {
                      ref.read(quizParamsProvider.notifier).setParams(
                            quiz.copyWith(
                                numberOfQuestions: maxNumberOfQuestions),
                          );
                      return;
                    }

                    if (int.parse(value) > 5) {
                      ref.read(quizParamsProvider.notifier).setParams(
                            quiz.copyWith(
                                numberOfQuestions: maxNumberOfQuestions),
                          );
                      return;
                    }

                    if (int.parse(value) < 1) {
                      ref.read(quizParamsProvider.notifier).setParams(
                            quiz.copyWith(numberOfQuestions: 1),
                          );
                      return;
                    }

                    ref.read(quizParamsProvider.notifier).setParams(
                        quiz.copyWith(numberOfQuestions: int.parse(value)));
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instant Feedback:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Switch(
                value: quiz.instaFeedback,
                onChanged: (value) {
                  ref
                      .read(quizParamsProvider.notifier)
                      .setParams(quiz.copyWith(instaFeedback: value));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
