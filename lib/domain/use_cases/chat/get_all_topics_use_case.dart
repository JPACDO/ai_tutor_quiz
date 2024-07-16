import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';

import '../base_usecase.dart';

class GetAllTopicsUseCase implements BaseUseCase<List<Topic>, String> {
  final TopicRepository _topicRepository;

  GetAllTopicsUseCase(this._topicRepository);

  /// [data] is userId
  @override
  Future<List<Topic>> call({required String data}) {
    return _topicRepository.getAllTopics(userId: data);
  }
}
