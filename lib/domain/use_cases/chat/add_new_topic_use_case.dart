import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';

import '../base_usecase.dart';

/// Use case to add a new topic to the repository.
///
/// This class encapsulates the logic to add a new topic to the repository.
/// It follows the Command design pattern.
class AddNewTopicsUseCase implements BaseUseCase<Topic, Topic> {
  /// The repository where the topic will be added.
  final TopicRepository _topicRepository;

  /// Creates an instance of [AddNewTopicsUseCase].
  ///
  /// The [topicRepository] parameter is the repository where the topic will be
  /// added.
  AddNewTopicsUseCase(this._topicRepository);

  /// Adds a new topic to the repository.
  ///
  /// The [data] parameter is the topic to be added.
  ///
  /// Returns a [Future] that completes with the added topic.
  @override
  Future<Topic> call({required Topic data}) {
    return _topicRepository.addNewTopic(topic: data);
  }
}
