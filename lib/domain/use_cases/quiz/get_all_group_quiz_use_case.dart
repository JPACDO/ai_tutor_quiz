import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';

import '../base_usecase.dart';

class GetAllGroupQuizUseCase extends BaseUseCase<List<GroupQuiz>, String> {
  final GroupQuizRepository _groupQuizRepository;

  GetAllGroupQuizUseCase(this._groupQuizRepository);

  /// [prompt] is userId
  @override
  Future<List<GroupQuiz>> call({String? prompt}) {
    if (prompt == null) return Future.value([]);
    return _groupQuizRepository.getAllGroupQuiz(userId: prompt);
  }
}
