import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/infrastructure/mappers/chat/msg_mapper.dart';
import 'package:ai_tutor_quiz/infrastructure/models/isar_response/chat/topic.dart';
import 'package:ai_tutor_quiz/config/constants/values.dart';

extension TopicResponseLocalMapper on TopicResponseLocal? {
  Topic toDomain() {
    return Topic(
      id: this?.isarId.toString(),
      name: this?.name ?? empty,
      messages: this?.messages?.map((e) => e.toDomain()).toList() ?? [],
      userId: this?.userId ?? empty,
    );
  }
}
