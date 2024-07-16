import 'package:ai_tutor_quiz/domain/entities/quiz/question.dart';

class GroupQuestions {
  final String? id;
  final String name;
  final String? description;
  final List<Question> questions;
  final String userId;

  GroupQuestions(
      {this.id,
      required this.name,
      this.description,
      required this.questions,
      required this.userId});

  @override
  String toString() {
    return '''
    GroupQuestions{
      id: $id,
      name: $name, 
      description: $description, 
      questions: $questions
      userId: $userId
    }''';
  }

  GroupQuestions copyWith(
      {String? id,
      String? name,
      String? description,
      List<Question>? questions,
      String? userId}) {
    return GroupQuestions(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        questions: questions ?? this.questions,
        userId: userId ?? this.userId);
  }
}
