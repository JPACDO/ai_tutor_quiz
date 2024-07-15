import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class AddNewGroupQuestionsUseCase
    extends BaseUseCase<GroupQuestions, GroupQuestions> {
  final GroupQuestionsRepository _groupQuestionsRepository;

  AddNewGroupQuestionsUseCase(this._groupQuestionsRepository);

  /// [data] is userId
  @override
  Future<GroupQuestions> call({required GroupQuestions data}) {
    return _groupQuestionsRepository.newGroupQuestion(group: data);
  }
}