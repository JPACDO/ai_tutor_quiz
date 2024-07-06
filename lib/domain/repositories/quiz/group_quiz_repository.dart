import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class GroupQuizRepository {
  Future<List<GroupQuiz>> getAllGroupQuiz({String userId});

  Future<bool> deleteAllGroupQuiz({String userId});

  Future<GroupQuiz> getGroupQuiz({String id});

  Future<bool> deleteGroupQuiz({String id});

  Future<bool> saveGroupQuiz({required GroupQuiz groupQuiz});

  Future<bool> updateGroupQuiz({required GroupQuiz groupQuiz});
}
