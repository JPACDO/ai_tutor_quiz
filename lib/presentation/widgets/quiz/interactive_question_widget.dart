import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractiveQuestion extends ConsumerStatefulWidget {
  const InteractiveQuestion(
      {super.key,
      required this.index,
      required this.question,
      required this.onNextPage,
      required this.showNextButton});
  final int index;
  final Question question;
  final bool showNextButton;
  final VoidCallback onNextPage;

  @override
  ConsumerState<InteractiveQuestion> createState() =>
      _InteractiveQuestionState();
}

class _InteractiveQuestionState extends ConsumerState<InteractiveQuestion> {
  bool showOpenAnswer = false;

  @override
  Widget build(BuildContext context) {
    final bool instaFeed = ref.read(quizParamsProvider).instaFeedback;
    final userResponse = ref.watch(quizUserResponseProvider);

    final int? selected = (userResponse.length > widget.index)
        ? userResponse[widget.index]
        : null;

    bool isLocked = (selected != null) && (instaFeed);

    final bool isOpenAnswer = widget.question.type == QuizType.openAnswer;
    final List<Widget> alternatives = [];

    for (var alternative in widget.question.alternatives) {
      int indexAlternative = widget.question.alternatives.indexOf(alternative);

      Color color = Colors.transparent;
      Widget alternativeWidget =
          Text(alternative, style: const TextStyle(fontSize: 18.0));

      if (selected == indexAlternative) {
        color = Colors.orangeAccent.shade100;
      }

      if (isLocked &&
          (widget.question.correctAnswerIndex == indexAlternative)) {
        color = Colors.green.shade100;
        alternativeWidget = Row(
          children: [
            const Icon(Icons.check),
            Flexible(child: alternativeWidget)
          ],
        );
      }

      alternatives.add(
        GestureDetector(
          child: Container(
            width: double.maxFinite,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(),
                // borderRadius: BorderRadius.circular(20.0),
                color: color),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isOpenAnswer
                    ? TextFormField(
                        maxLines: 6,
                      )
                    : alternativeWidget,
                (showOpenAnswer &&
                        widget.question.correctAnswerIndex == indexAlternative)
                    ? alternativeWidget
                    : Container(),
              ],
            ),
          ),
          onTap: () {
            if (isLocked) return;
            ref
                .read(quizUserResponseProvider.notifier)
                .setResponse(index: widget.index, response: indexAlternative);
          },
        ),
      );

      if (isOpenAnswer) {
        break;
      }
    }

    return Container(
      padding: const EdgeInsets.all(30.0),
      // color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.save),
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.question.question,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...alternatives,
            const SizedBox(height: 20),
            Text(widget.question.correctAnswerIndex.toString()),
            Text(widget.question.type.toString()),
            const SizedBox(height: 50),
            (selected != null && widget.showNextButton || isOpenAnswer)
                ? Center(
                    child: FilledButton(
                        onPressed: () {
                          if (isOpenAnswer && !showOpenAnswer) {
                            showOpenAnswer = true;
                            ref
                                .read(quizUserResponseProvider.notifier)
                                .setResponse(index: widget.index, response: 0);
                            return;
                          }

                          widget.onNextPage();
                        },
                        child: (!showOpenAnswer && isOpenAnswer)
                            ? const Text('Check')
                            : const Text('Next')),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
