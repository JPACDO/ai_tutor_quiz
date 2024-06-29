import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class UserDatasource {
  Future<User> getHistoryChat();
}
