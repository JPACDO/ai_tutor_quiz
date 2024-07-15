import 'package:ai_tutor_quiz/domain/entities/quiz/group_questions.dart';
import 'package:ai_tutor_quiz/domain/entities/quiz/question.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';

class GroupQuestionsRepositoryImpl implements GroupQuestionsRepository {
  final LocalStorageDbChatDatasource _localStorageDbChatDatasource;

  GroupQuestionsRepositoryImpl(this._localStorageDbChatDatasource);

  @override
  Future<bool> deleteAllGroupQuestion({required String userId}) async {
    return await _localStorageDbChatDatasource.deleteAllGroupQuestion(
        userId: userId);
  }

  @override
  Future<bool> deleteGroupQuestion({required String id}) async {
    return await _localStorageDbChatDatasource.deleteGroupQuestion(id: id);
  }

  @override
  Future<List<GroupQuestions>> getAllGroupQuestion(
      {required String userId}) async {
    return await _localStorageDbChatDatasource.getAllGroupQuestion(
        userId: userId);
  }

  @override
  Future<GroupQuestions> getGroupQuestion({required String id}) async {
    return await _localStorageDbChatDatasource.getGroupQuestion(id: id);
  }

  @override
  Future<GroupQuestions> newGroupQuestion(
      {required GroupQuestions group}) async {
    return await _localStorageDbChatDatasource.newGroupQuestion(group: group);
  }

  @override
  Future<bool> updateGroupQuestion({required GroupQuestions group}) async {
    return await _localStorageDbChatDatasource.updateGroupQuestion(
        group: group);
  }

  @override
  Future<bool> addQuestiontoGroup(
      {required String groupId, required Question question}) async {
    return await _localStorageDbChatDatasource.addQuestionInGroup(
        groupId: groupId, question: question);
  }
}
