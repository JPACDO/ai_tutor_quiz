import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class HistoryQuizDatasource {
  Future<User> getHistoryChat();
}
