import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class GroupQuestionsDatasource {
  Future<List<GroupQuestions>> getAllGroupQuestion({required String userId});

  Future<bool> deleteAllGroupQuestion({required String userId});

  Future<GroupQuestions?> getGroupQuestion({required String id});

  Future<bool> deleteGroupQuestion({required String id});

  Future<GroupQuestions> newGroupQuestion({required GroupQuestions group});

  Future<bool> updateGroupQuestion({required GroupQuestions group});

  Future<Question> addQuestionInGroup(
      {required String groupId, required Question question});

  Future<bool> deleteQuestionOfGroup(
      {required String groupId, required String questionId});
}
