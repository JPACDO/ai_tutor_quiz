import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class AddQuestionInGoroupUseCase extends BaseUseCase<bool, Question> {
  final GroupQuestionsRepository _groupQuestionsRepository;

  AddQuestionInGoroupUseCase(this._groupQuestionsRepository);

  /// [data] is userId
  @override
  Future<bool> call({required Question data, String? groupId}) {
    if (groupId == null) return Future.value(false);
    return _groupQuestionsRepository.addQuestiontoGroup(
        groupId: groupId, question: data);
  }
}
