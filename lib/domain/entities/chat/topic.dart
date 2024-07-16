import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';

class Topic {
  final String? id;
  final String name;
  final List<Message?> messages;
  final String userId;

  Topic(
      {this.id,
      required this.name,
      required this.messages,
      required this.userId});

  copyWith(
      {String? id, String? name, List<Message?>? messages, String? userId}) {
    return Topic(
      id: id ?? this.id,
      name: name ?? this.name,
      messages: messages ?? this.messages,
      userId: userId ?? this.userId,
    );
  }
}
