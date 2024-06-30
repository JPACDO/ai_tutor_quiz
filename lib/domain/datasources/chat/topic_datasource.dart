import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class TopicDatasource {
  Future<List<Message>> getTopic();
}
