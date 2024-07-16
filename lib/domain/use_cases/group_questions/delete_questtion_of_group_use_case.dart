import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class DeleteQuestionOfGoroupUseCase extends BaseUseCase<bool, String> {
  final GroupQuestionsRepository _groupQuestionsRepository;

  DeleteQuestionOfGoroupUseCase(this._groupQuestionsRepository);

  @override
  Future<bool> call({required String data, String? groupId}) {
    if (groupId == null) throw Exception('GroupId null');
    return _groupQuestionsRepository.deleteQuestionOfGroup(
        questionId: data, groupId: groupId);
  }
}
