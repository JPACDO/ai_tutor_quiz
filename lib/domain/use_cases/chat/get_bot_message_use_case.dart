import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class GetBotMessageUseCase implements BaseUseCase<Message?, String> {
  final MessageRepository _messageRepository;

  GetBotMessageUseCase(this._messageRepository);

  /// [data] is the prompt to get the bot response
  @override
  Future<Message?> call({required String data, String? imgUrl, Topic? topic}) {
    return _messageRepository.getBotMessage(
        prompt: data, imgUrl: imgUrl, topic: topic!);
  }
}
