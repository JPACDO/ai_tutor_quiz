import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class TopicUseCase {
  final TopicGateway topicGateway;

  TopicUseCase({required this.topicGateway});

  Future<Topic> getTopic() async {
    return await topicGateway.getTopic();
  }
}
