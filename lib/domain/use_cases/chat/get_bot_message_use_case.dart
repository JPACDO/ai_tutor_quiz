import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class GetBotMessageUseCase implements BaseUseCase<Message?, String> {
  final MessageRepository _messageRepository;

  GetBotMessageUseCase(this._messageRepository);

  /// [params] is the prompt to get the bot response
  @override
  Future<Message?> call({String? params, String? imgUrl, Topic? topic}) {
    if (params == null) return Future.value(null);
    return _messageRepository.getBotMessage(
        prompt: params, imgUrl: imgUrl, topic: topic!);
  }
}
