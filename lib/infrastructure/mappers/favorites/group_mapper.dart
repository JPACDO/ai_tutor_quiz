import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/infrastructure/models/isar_response/quiz/group_questions.dart';
import 'package:ai_tutor_quiz/config/constants/values.dart';

extension GroupsResponseLocalMapper on GroupQuestionsResponseLocal? {
  GroupQuestions toDomain() {
    return GroupQuestions(
      id: this?.isarId.toString(),
      name: this?.name ?? empty,
      description: this?.description ?? empty,
      questions: this?.questions?.map((e) => e.toDomain()).toList() ?? [],
      userId: this?.userId ?? empty,
    );
  }
}

extension QuestionResponseLocalMapper on QuestionResponseLocal? {
  Question toDomain() {
    return Question(
      id: this!.id.toString(),
      question: this?.question ?? empty,
      alternatives: this?.alternatives ?? [],
      correctAnswerIndex: this?.correctAnswerIndex ?? zero,
      type: this?.type ?? QuizType.multipleChoice,
    );
  }
}
