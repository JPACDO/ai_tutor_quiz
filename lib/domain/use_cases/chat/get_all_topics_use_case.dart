import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';

import '../base_usecase.dart';

class GetAllTopicsUseCase implements BaseUseCase<List<Topic>, String> {
  final TopicRepository _topicRepository;

  GetAllTopicsUseCase(this._topicRepository);

  /// [params] is userId
  @override
  Future<List<Topic>> call({String? params}) {
    if (params == null) return Future.value([]);
    return _topicRepository.getAllTopics(userId: params);
  }
}
