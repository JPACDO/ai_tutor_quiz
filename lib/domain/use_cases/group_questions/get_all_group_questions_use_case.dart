import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

/// Use case for getting all group questions from the repository.
///
/// This use case is responsible for retrieving all group questions from the
/// repository. It takes a [String] object (userId) as input and returns a
/// [Future<List<GroupQuestions>>] object.
class GetAllGroupQuestionsUseCase
    extends BaseUseCase<List<GroupQuestions>, String> {
  /// The repository responsible for handling group questions.
  final GroupQuestionsRepository _groupQuestionsRepository;

  /// Constructs a [GetAllGroupQuestionsUseCase] instance.
  ///
  /// The [groupQuestionsRepository] parameter is the repository responsible
  /// for handling group questions.
  GetAllGroupQuestionsUseCase(this._groupQuestionsRepository);

  /// Gets all group questions from the repository.
  ///
  /// The [data] parameter is the userId.
  ///
  /// Returns a [Future] that completes with a [List<GroupQuestions>].
  @override
  Future<List<GroupQuestions>> call({required String data}) {
    return _groupQuestionsRepository.getAllGroupQuestion(userId: data);
  }
}
