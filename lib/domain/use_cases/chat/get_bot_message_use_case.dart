import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

class GetBotMessageUseCase implements BaseUseCase<Message?, String> {
  final MessageRepository _messageRepository;

  GetBotMessageUseCase(this._messageRepository);

  /// [prompt] is the prompt to get the bot response
  @override
  Future<Message?> call({String? prompt, String? imgUrl, Topic? topic}) {
    if (prompt == null) return Future.value(null);
    return _messageRepository.getBotMessage(
        prompt: prompt, imgUrl: imgUrl, topic: topic!);
  }
}
