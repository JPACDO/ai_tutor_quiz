import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';

import '../base_usecase.dart';

class AddNewTopicsUseCase implements BaseUseCase<Topic, Topic> {
  final TopicRepository _topicRepository;

  AddNewTopicsUseCase(this._topicRepository);

  /// [prompt] is the topic to be added
  @override
  Future<Topic> call({Topic? prompt}) {
    return _topicRepository.addNewTopic(topic: prompt!);
  }
}
