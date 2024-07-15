import 'package:ai_tutor_quiz/domain/entities/quiz/question.dart';

class GroupQuestions {
  final String? idDb;
  final String name;
  final String? description;
  final List<Question> questions;

  GroupQuestions(
      {this.idDb,
      required this.name,
      this.description,
      required this.questions});

  @override
  String toString() {
    return '''
    GroupQuestions{
      idDb: $idDb,
      name: $name, 
      description: $description, 
      questions: $questions
    }''';
  }

  GroupQuestions copyWith(
      {String? idDb,
      String? name,
      String? description,
      List<Question>? questions}) {
    return GroupQuestions(
        idDb: idDb,
        name: name ?? this.name,
        description: description ?? this.description,
        questions: questions ?? this.questions);
  }
}
