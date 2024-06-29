import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class UserRepository {
  Future<User> getHistoryChat();
}
