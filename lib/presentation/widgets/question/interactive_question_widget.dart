import 'package:flutter/material.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';

/// Creates a list of [InteractiveQuestion] widgets from a list of [Question]s.
///
/// The function takes in several parameters:
/// - [quiz]: the list of questions to be displayed.
/// - [onNextPage]: an optional callback function that is called when the user
///   clicks the 'Next' button.
/// - [showNextButton]: a boolean indicating whether the 'Next' button should be
///   visible.
/// - [showAnswers]: a boolean indicating whether the answers should be shown inmediately.
/// - [instaFeed]: a boolean indicating whether the feedback should be instant.
/// - [onPressAnswer]: an optional callback function that is called when the user
///   selects an answer. The function takes in two parameters: the index of the
///   question and the index of the selected answer. Function (int index, int response)? onPressAnswer,
/// - [userResponse]: a list of integers representing the user's responses to the
///   questions.
/// - [showSaveicon]: a boolean indicating whether the save icon should be shown.
/// - [padding]: an optional padding value for the widget.
List<Widget> interactiveQuestions(
    {required List<Question> quiz,
    Function(Question)? onNextPage,
    required bool showNextButton,
    required bool showAnswers,
    required bool instaFeed,
    Function(int, int)? onPressAnswer,
    List<int?>? userResponse,
    Function(Question)? onSave,
    EdgeInsetsGeometry? padding,
    bool divider = false}) {
  final List<Widget> questionWidget = [];

  for (var question in quiz) {
    questionWidget.add(InteractiveQuestion(
      index: quiz.indexOf(question),
      question: question,
      onNextPage: () => {if (onNextPage != null) onNextPage(question)},
      showNextButton: showNextButton,
      showAnswers: showAnswers,
      padding: padding ?? const EdgeInsets.all(30.0),
      onSave: onSave,
      instaFeed: instaFeed,
      userResponse: userResponse,
      onPressAnswer: onPressAnswer ?? (index, response) {},
    ));

    if (divider) {
      questionWidget.add(const Divider());
    }
  }
  return questionWidget;
}

class InteractiveQuestion extends StatefulWidget {
  const InteractiveQuestion(
      {super.key,
      required this.padding,
      required this.index,
      required this.question,
      required this.showAnswers,
      required this.onNextPage,
      required this.showNextButton,
      required this.onSave,
      required this.instaFeed,
      required this.userResponse,
      required this.onPressAnswer});
  final int index;
  final Question question;
  final bool showNextButton;
  final bool showAnswers;
  final VoidCallback onNextPage;
  final EdgeInsetsGeometry padding;
  final Function(Question)? onSave;
  final bool instaFeed;
  final List<int?>? userResponse;
  final Function(int, int) onPressAnswer;

  @override
  State<InteractiveQuestion> createState() => _InteractiveQuestionState();
}

class _InteractiveQuestionState extends State<InteractiveQuestion> {
  bool showOpenAnswer = false;
  int? userResponseInt;

  @override
  Widget build(BuildContext context) {
    final bool instaFeed =
        widget.instaFeed; //ref.read(quizParamsProvider).instaFeedback;
    // final userResponse = widget.userResponse ??
    // userResponseInt; //ref.watch(quizUserResponseProvider);

    final int? selected = widget.userResponse != null
        ? (widget.userResponse!.length > widget.index)
            ? widget.userResponse![widget.index]
            : null
        : userResponseInt;

    bool isLocked = (selected != null) && (instaFeed) || widget.showAnswers;

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
                        maxLines: widget.showNextButton ? 6 : 1,
                      )
                    : alternativeWidget,
                ((showOpenAnswer || !widget.showNextButton) &&
                        widget.question.correctAnswerIndex ==
                            indexAlternative &&
                        isOpenAnswer)
                    ? alternativeWidget
                    : Container(),
              ],
            ),
          ),
          onTap: () {
            if (isLocked) return;

            widget.onPressAnswer(widget.index, indexAlternative);
            setState(() {
              userResponseInt = indexAlternative;
            });
          },
        ),
      );

      if (isOpenAnswer) {
        break;
      }
    }

    return Container(
      padding: widget.padding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.onSave != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        widget.onSave!(widget.question);
                      },
                      icon: const Icon(Icons.save),
                    ),
                  )
                : Container(),
            const SizedBox(height: 20),
            Text(widget.question.question,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...alternatives,
            const SizedBox(height: 20),
            // Text(widget.question.correctAnswerIndex.toString()),
            // Text(widget.question.type.toString()),
            widget.showNextButton ? const SizedBox(height: 50) : Container(),
            ((selected != null || isOpenAnswer) && widget.showNextButton)
                ? Center(
                    child: FilledButton(
                        onPressed: () {
                          if (isOpenAnswer && !showOpenAnswer) {
                            showOpenAnswer = true;
                            userResponseInt = 0;
                            setState(() {});
                            widget.onPressAnswer(widget.index, 0);
                            // ref
                            //     .read(quizUserResponseProvider.notifier)
                            //     .setResponse(index: widget.index, response: 0);
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
