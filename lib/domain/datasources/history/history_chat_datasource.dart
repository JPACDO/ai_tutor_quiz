import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class HistoryChatDatasource {
  Future<List<Message>> getHistoryChat();
}
