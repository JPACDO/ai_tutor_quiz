import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:isar/isar.dart';

part 'topic.g.dart';

@collection
class TopicResponseLocal {
  Id? isarId;
  String? name;
  List<MessageResponseLocal?>? messages;

  String? userId;
  DateTime? createdAt;

  TopicResponseLocal(
      {this.isarId, this.name, this.messages, this.userId, this.createdAt});

  copyWith(
      {int? id,
      String? name,
      List<MessageResponseLocal?>? messages,
      String? userId,
      DateTime? createdAt}) {
    return TopicResponseLocal(
        isarId: id,
        name: name ?? this.name,
        messages: messages ?? this.messages,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt);
  }
}

@embedded
class MessageResponseLocal {
  String? content;
  String? imgUrl;
  @Enumerated(EnumType.name)
  SenderType? sender;
}
