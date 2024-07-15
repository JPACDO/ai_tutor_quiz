import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class GroupQuestionsRepository {
  Future<List<GroupQuestions>> getAllGroupQuestion({required String userId});

  Future<bool> deleteAllGroupQuestion({required String userId});

  Future<GroupQuestions> getGroupQuestion({required String id});

  Future<bool> deleteGroupQuestion({required String id});

  Future<GroupQuestions> newGroupQuestion({required GroupQuestions group});

  Future<bool> updateGroupQuestion({required GroupQuestions group});

  Future<bool> addQuestiontoGroup(
      {required String groupId, required Question question});
}
