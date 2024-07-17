import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';

import '../base_usecase.dart';

/// Use case for getting all topics of a user.
///
/// This use case acts as an intermediary between the presentation layer and
/// the data layer. It encapsulates the logic for getting all topics of a user.
/// It takes a [userId] as input and returns a [List] of [Topic] entities.
class GetAllTopicsUseCase implements BaseUseCase<List<Topic>, String> {
  /// The repository that provides the data source for the use case.
  final TopicRepository _topicRepository;

  /// Creates a new instance of [GetAllTopicsUseCase] with the given
  /// [topicRepository].
  GetAllTopicsUseCase(this._topicRepository);

  /// [data] is userId
  ///
  /// Calls the [_topicRepository]'s [getAllTopics] method with the given
  /// [userId] and returns the resulting [List] of [Topic] entities.
  @override
  Future<List<Topic>> call({required String data}) {
    return _topicRepository.getAllTopics(userId: data);
  }
}
