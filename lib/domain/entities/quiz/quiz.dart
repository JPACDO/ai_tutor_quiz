import 'package:ai_tutor_quiz/domain/entities/entities.dart';

enum QuizType {
  trueFalse("True/False"),
  multipleChoice("Multiple Choice"),
  openAnswer("Written");

  final String displayValue;

  const QuizType(this.displayValue);

  @override
  String toString() {
    return displayValue;
  }

  static QuizType fromString(String value, int numOfChoices) {
    for (var element in values) {
      if (element.toString() == value) {
        return element;
      }
    }

    switch (numOfChoices) {
      case 1:
        return QuizType.openAnswer;
      case 2:
        return QuizType.trueFalse;
      case > 2:
        return QuizType.multipleChoice;
      default:
        break;
    }
    throw ArgumentError("No matching QuizType for '$value'");
  }
}

class Quiz {
  final Set<QuizType> type;
  final List<Question> questions;
  final String language;
  final int numberOfQuestions;
  final String difficulty;
  final bool instaFeedback;

  const Quiz(
      {required this.type,
      required this.questions,
      required this.language,
      required this.numberOfQuestions,
      required this.difficulty,
      required this.instaFeedback});

  Quiz copyWith(
      {Set<QuizType>? type,
      List<Question>? questions,
      String? language,
      int? numberOfQuestions,
      String? difficulty,
      bool? instaFeedback}) {
    return Quiz(
        type: type ?? this.type,
        questions: questions ?? this.questions,
        language: language ?? this.language,
        numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
        difficulty: difficulty ?? this.difficulty,
        instaFeedback: instaFeedback ?? this.instaFeedback);
  }

  @override
  String toString() {
    return '''
    Quiz{
      type: $type, 
      questions: $questions, 
      language: $language, 
      numberOfQuestions: $numberOfQuestions, 
      difficulty: $difficulty, 
      instaFeedback: $instaFeedback
    }
    ''';
  }
}
