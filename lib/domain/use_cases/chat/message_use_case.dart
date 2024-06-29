import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class MessageUseCase {
  final MessageGateway messageGateway;

  MessageUseCase({required this.messageGateway});

  Future<Message> getMessage() async {
    return await messageGateway.getMessage();
  }
}
