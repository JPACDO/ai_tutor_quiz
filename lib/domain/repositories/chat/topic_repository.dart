import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class TopicRepository {
  Future<List<Topic>> getAllTopics({required String userId});

  Future<Topic> getTopic({required String topicId});

  Future<Topic> addNewTopic({required Topic topic});

  Future<bool> updateTopic({required Topic topic});

  Future<bool> deleteTopic({required String id});

  Future<bool> deleteAllMessagesOfTopic({required String topicId});

  Future<bool> deleteAllTopics(String userId);
}
