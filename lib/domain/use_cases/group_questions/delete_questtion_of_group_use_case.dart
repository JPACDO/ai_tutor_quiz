import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

/// Use case to delete a question of a group.
///
/// This use case takes [data] and [groupId] as parameters.
/// [data] is the id of the question to be deleted and [groupId] is the id of the group.
/// It returns a [Future] that completes with a [bool] representing the success of the operation.
///
/// Throws an [Exception] if [groupId] is null.
class DeleteQuestionOfGoroupUseCase extends BaseUseCase<bool, String> {
  final GroupQuestionsRepository _groupQuestionsRepository;

  /// Creates a new instance of [DeleteQuestionOfGoroupUseCase]
  ///
  /// Takes a [GroupQuestionsRepository] as a parameter.
  DeleteQuestionOfGoroupUseCase(this._groupQuestionsRepository);

  @override
  Future<bool> call({required String data, String? groupId}) {
    if (groupId == null) throw Exception('GroupId null');
    return _groupQuestionsRepository.deleteQuestionOfGroup(
        questionId: data, groupId: groupId);
  }
}
