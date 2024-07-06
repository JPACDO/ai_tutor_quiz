import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class TopicDatasource {
  Future<List<Topic>> getAllTopics(String userId);

  Future<Topic> getTopic({required String topicId});

  Future<Topic> addTopic({required Topic topic});

  Future<bool> updateTopic({required Topic topic});

  Future<bool> deleteTopic({required String id});

  Future<bool> saveTopicMessage(
      {required String topicId, required String messageId});

  Future<bool> deleteTopicMessage(
      {required String topicId, required String messageId});

  Future<bool> deleteAllTopicMessages({required String topicId});

  Future<bool> deleteAllTopics(String userId);
}
