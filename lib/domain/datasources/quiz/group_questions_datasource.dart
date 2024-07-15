import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class GroupQuestionsDatasource {
  Future<List<GroupQuestions>> getAllGroupQuestion({required String userId});

  Future<bool> deleteAllGroupQuestion({required String userId});

  Future<GroupQuestions> getGroupQuestion({required String id});

  Future<bool> deleteGroupQuestion({required String id});

  Future<bool> newGroupQuestion({required GroupQuestions group});

  Future<bool> updateGroupQuestion({required GroupQuestions group});

  Future<bool> addQuestionInGroup(
      {required String groupId, required Question question});
}
