import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class TopicRepository {
  Future<List<Message>> getTopic();
}
