import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class HistoryQuizRepository {
  Future<User> getHistoryChat();
}
