import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GetBotMessageUseCase implements BaseUseCase<Message?, String> {
  final MessageRepository _messageRepository;

  GetBotMessageUseCase(this._messageRepository);

  /// [params] is the prompt to get the bot response
  @override
  Future<Message?> call(
      {String? params, String? imgUrl, List<Content>? chatSession}) {
    if (params == null) return Future.value(null);
    return _messageRepository.getBotMessage(
        prompt: params, imgUrl: imgUrl, history: chatSession!);
  }
}
