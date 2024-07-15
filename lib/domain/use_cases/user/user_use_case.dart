import 'package:ai_tutor_quiz/domain/entities/entities.dart';

import '../../repositories/repositories.dart';
import '../base_usecase.dart';

class UserUseCase extends BaseUseCase<User, String> {
  final UserRepository _userRepository;
  UserUseCase(this._userRepository);

  @override
  Future<User> call({String? data}) {
    return _userRepository.getUser(userId: data!);
  }
}
