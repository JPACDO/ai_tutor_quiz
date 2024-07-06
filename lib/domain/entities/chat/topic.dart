import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';

class Topic {
  final String? idDb;
  final String name;
  final List<Message?> messages;

  Topic({required this.idDb, required this.name, required this.messages});

  copyWith({String? idDb, String? name, List<Message?>? messages}) {
    return Topic(
      idDb: idDb ?? this.idDb,
      name: name ?? this.name,
      messages: messages ?? this.messages,
    );
  }
}
