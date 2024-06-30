import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class GroupQuizUseCase {
  final GroupQuizGateway groupQuizGateway;

  GroupQuizUseCase({required this.groupQuizGateway});

  Future<GroupQuiz> getGroupQuiz() {
    return groupQuizGateway.getGroupQuiz();
  }
}
