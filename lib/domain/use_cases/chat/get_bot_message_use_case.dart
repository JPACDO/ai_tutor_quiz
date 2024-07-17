import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/domain/use_cases/base_usecase.dart';

/// Use case to get a bot message based on a prompt and optional image and topic.
///
/// This class encapsulates the logic to get a bot message based on a prompt,
/// optional image and topic. It follows the Command design pattern.
///
/// It takes a [data] as input, which is the prompt to get the bot response.
/// It also takes an optional [imgUrl] and [topic].
///
/// It returns a [Future] that completes with a [Message] or null if no message
/// is found.
class GetBotMessageUseCase implements BaseUseCase<Message?, String> {
  /// The repository that handles the business logic.
  final MessageRepository _messageRepository;

  /// Creates a new instance of [GetBotMessageUseCase].
  ///
  /// The [_messageRepository] parameter is required and must not be null.
  GetBotMessageUseCase(this._messageRepository);

  /// Gets a bot message based on the prompt, optional image and topic.
  ///
  /// The [data] parameter is required and must not be null. It represents the
  /// prompt to get the bot response.
  ///
  /// The [imgUrl] parameter is optional. It represents the URL of an image.
  ///
  /// The [topic] parameter is required and must not be null.
  /// It is used to send the history of the conversation.
  ///
  /// Returns a [Future] that completes with a [Message] or null if no message
  /// is returned.
  @override
  Future<Message?> call({required String data, String? imgUrl, Topic? topic}) {
    return _messageRepository.getBotMessage(
        prompt: data, imgUrl: imgUrl, topic: topic!);
  }
}
