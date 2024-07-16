import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class Question {
  String? id;
  String question;
  List<String> alternatives;
  int correctAnswerIndex;
  QuizType type;

  Question(
      {this.id,
      required this.question,
      required this.alternatives,
      required this.correctAnswerIndex,
      required this.type});

  Question copyWith(
      {String? id,
      String? question,
      List<String>? alternatives,
      int? correctAnswerIndex,
      QuizType? type}) {
    return Question(
        id: id ?? this.id,
        question: question ?? this.question,
        alternatives: alternatives ?? this.alternatives,
        correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
        type: type ?? this.type);
  }

  @override
  String toString() {
    return '''
    Question{
      id: $id,
      question: $question, 
      alternatives: $alternatives, 
      correctAnswerIndex: $correctAnswerIndex, 
      type: $type
    }''';
  }
}
