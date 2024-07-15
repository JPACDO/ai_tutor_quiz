import 'package:ai_tutor_quiz/domain/entities/chat/topic.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';

class TopicRepositoryImpl implements TopicRepository {
  final LocalStorageDbChatDatasource _localStorageDbChatDatasource;

  TopicRepositoryImpl(this._localStorageDbChatDatasource);

  @override
  Future<bool> deleteAllMessagesOfTopic({required String topicId}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAllTopics(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTopic({required String id}) {
    return _localStorageDbChatDatasource.deleteTopic(id: id);
  }

  @override
  Future<List<Topic>> getAllTopics({required String userId}) {
    return _localStorageDbChatDatasource.getAllTopics(userId);
  }

  @override
  Future<Topic> addNewTopic({required Topic topic}) {
    return _localStorageDbChatDatasource.addTopic(topic: topic);
  }

  @override
  Future<Topic> getTopic({required String topicId}) {
    return _localStorageDbChatDatasource.getTopic(topicId: topicId);
  }

  @override
  Future<bool> updateTopic({required Topic topic}) {
    return _localStorageDbChatDatasource.updateTopic(topic: topic);
  }
}
