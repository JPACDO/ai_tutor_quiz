import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class AddQuestionInGoroupUseCase extends BaseUseCase<Question, Question> {
  final GroupQuestionsRepository _groupQuestionsRepository;

  AddQuestionInGoroupUseCase(this._groupQuestionsRepository);

  @override
  Future<Question> call({required Question data, String? groupId}) {
    if (groupId == null) throw Exception('GroupId null');
    return _groupQuestionsRepository.addQuestiontoGroup(
        groupId: groupId, question: data);
  }
}
