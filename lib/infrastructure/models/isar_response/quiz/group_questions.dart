import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:isar/isar.dart';

part 'group_questions.g.dart';

@collection
class GroupQuestionsResponseLocal {
  Id? isarId;
  final String? name;
  final String? description;
  List<QuestionResponseLocal>? questions;
  String? userId;

  GroupQuestionsResponseLocal({
    this.isarId,
    required this.name,
    this.description,
    this.questions,
    this.userId,
  });

  @override
  String toString() {
    return '''
    GroupQuestions{
      id: $isarId,
      name: $name, 
      description: $description, 
      questions: $questions,
      userId: $userId,
    }''';
  }

  GroupQuestionsResponseLocal copyWith({
    int? id,
    String? name,
    String? description,
    List<QuestionResponseLocal>? questions,
    String? userId,
  }) {
    return GroupQuestionsResponseLocal(
        isarId: id,
        name: name ?? this.name,
        description: description ?? this.description,
        questions: questions ?? this.questions,
        userId: userId ?? this.userId);
  }
}

@embedded
class QuestionResponseLocal {
  String? id;
  String? question;
  List<String>? alternatives;
  int? correctAnswerIndex;
  @Enumerated(EnumType.name)
  QuizType? type;

  @override
  String toString() {
    return '''
    Question{
      id: $id,
      question: $question, 
      alternatives: $alternatives, 
      correctAnswerIndex: $correctAnswerIndex, 
      type: $type, 
    }''';
  }
}
