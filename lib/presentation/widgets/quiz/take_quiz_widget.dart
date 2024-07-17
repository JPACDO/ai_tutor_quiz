import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/quizzes/result_quiz_screen.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class TakeQuiz extends ConsumerStatefulWidget {
  const TakeQuiz({super.key, required this.questions, required this.instaFeed});
  final List<Question> questions;
  final bool instaFeed;

  @override
  ConsumerState<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends ConsumerState<TakeQuiz> {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();
    ref.read(quizUserResponseProvider.notifier).reset();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> questionWidget = interactiveQuestions(
      instaFeed: widget.instaFeed,
      quiz: widget.questions,
      showNextButton: true,
      showAnswers: false,
      onNextPage: (Question question) {
        if (question == widget.questions.last) {
          print(widget.questions);
          context.pushReplacementNamed(ResultQuizScreen.name,
              extra: widget.questions);
          return;
        }
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
      onPressAnswer: (index, response) {
        print('index: $index, response: $response');
        ref
            .read(quizUserResponseProvider.notifier)
            .setResponse(index: index, response: response);
      },
      onSave: (question) {
        return showModalBottomSheet(
            context: context,
            builder: (context) {
              return SaveQuestionWidget(
                question: question,
              );
            });
      },
    );

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      // index: pageIndex,
      children: questionWidget,
    );
  }
}
