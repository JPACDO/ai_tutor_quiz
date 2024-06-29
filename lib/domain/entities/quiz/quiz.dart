enum QuizType { trueFalse, multipleChoice, openAnswer }

class Quiz {
  String question;
  List<String> alternatives;
  int correctAnswerIndex;
  QuizType type;

  Quiz(
      {required this.question,
      required this.alternatives,
      required this.correctAnswerIndex,
      required this.type});
}
