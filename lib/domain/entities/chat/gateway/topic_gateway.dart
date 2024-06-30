import 'package:ai_tutor_quiz/domain/entities/chat/topic.dart';

abstract class TopicGateway {
  Future<Topic> getTopic();
}
