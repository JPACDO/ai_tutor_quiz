import 'package:ai_tutor_quiz/domain/entities/entities.dart';

abstract class UserRepository {
  Future<User> getUser({String userId});

  Future<bool> deleteUser({String userId});

  Future<bool> saveUser({required User user});

  Future<bool> updateUser({required User user});
}
