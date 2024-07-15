import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class GetAllGroupQuestionsUseCase
    extends BaseUseCase<List<GroupQuestions>, String> {
  final GroupQuestionsRepository _groupQuestionsRepository;

  GetAllGroupQuestionsUseCase(this._groupQuestionsRepository);

  /// [data] is userId
  @override
  Future<List<GroupQuestions>> call({required String data}) {
    return _groupQuestionsRepository.getAllGroupQuestion(userId: data);
  }
}
