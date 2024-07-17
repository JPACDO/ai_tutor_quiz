import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

/// Use case to add a new group of questions to the repository.
///
/// This use case is responsible for adding a new group of questions to the
/// repository. It takes a [GroupQuestions] object as input and returns a
/// [Future<GroupQuestions>] object.
class AddNewGroupQuestionsUseCase
    extends BaseUseCase<GroupQuestions, GroupQuestions> {
  /// The repository that handles the group questions.
  final GroupQuestionsRepository _groupQuestionsRepository;

  /// Creates an instance of [AddNewGroupQuestionsUseCase].
  ///
  /// Takes a [GroupQuestionsRepository] as a parameter.
  AddNewGroupQuestionsUseCase(this._groupQuestionsRepository);

  /// Calls the repository to add a new group of questions.
  ///
  /// Takes a [GroupQuestions] object as input and returns a [Future<GroupQuestions>]
  /// object.
  ///
  /// Throws an [Exception] if the [GroupQuestions] object already has an ID.
  @override
  Future<GroupQuestions> call({required GroupQuestions data}) {
    return _groupQuestionsRepository.newGroupQuestion(group: data);
  }
}
