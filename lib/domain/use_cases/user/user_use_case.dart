import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class UserUseCase {
  final UserGateway userGateway;
  UserUseCase({required this.userGateway});

  Future<User> getUser() async {
    return await userGateway.getUser();
  }
}
