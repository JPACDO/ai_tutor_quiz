import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';

class Topic {
  final String name;
  final List<Message> messages;

  Topic({required this.name, required this.messages});
}
