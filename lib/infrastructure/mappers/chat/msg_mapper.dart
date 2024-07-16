import 'package:ai_tutor_quiz/config/constants/values.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/infrastructure/models/isar_response/chat/topic.dart';

import '../../models/gemini_response/gemini_msg_chat_response.dart';

extension MessageResponseMapper on GeminiMsgResponse? {
  Message toDomain() {
    return Message(
      id: null,
      content: this?.response ?? empty,
      sender: SenderType.bot,
    );
  }
}

extension MessageResponseLocalMapper on MessageResponseLocal? {
  Message toDomain() {
    return Message(
        content: this?.content ?? empty,
        sender: this?.sender ?? SenderType.bot,
        imgUrl: this?.imgUrl);
  }
}
