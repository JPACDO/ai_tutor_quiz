import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

/// Use case for adding a question to a group.
///
/// This use case allows you to add a question to a group.
/// It takes a [Question] object and an optional [groupId] which is the id of the group where the question will be added.
///
/// If the [groupId] is null, it throws an [Exception] with the message 'GroupId null'.
///
/// Returns a [Future] that completes with the added [Question].
class AddQuestionInGoroupUseCase extends BaseUseCase<Question, Question> {
  /// The repository for group questions.
  final GroupQuestionsRepository _groupQuestionsRepository;

  /// Creates an instance of [AddQuestionInGoroupUseCase].
  ///
  /// The [groupQuestionsRepository] is the repository for group questions.
  AddQuestionInGoroupUseCase(this._groupQuestionsRepository);

  /// Adds a question to a group.
  ///
  /// The [data] is the question to be added.
  /// The [groupId] is the id of the group where the question will be added.
  ///
  /// Throws an [Exception] if [groupId] is null.
  ///
  /// Returns a [Future] that completes with the added [Question].
  @override
  Future<Question> call({required Question data, String? groupId}) {
    if (groupId == null) throw Exception('GroupId null');
    return _groupQuestionsRepository.addQuestiontoGroup(
        groupId: groupId, question: data);
  }
}
