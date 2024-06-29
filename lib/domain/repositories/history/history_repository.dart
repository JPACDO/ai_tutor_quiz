import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class HistoryChatRepository {
  Future<List<Message>> getHistoryChat();
}
