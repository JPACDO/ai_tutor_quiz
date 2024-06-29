import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';

abstract class MessageGateway {
  Future<Message> getMessage();
}
