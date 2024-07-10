import 'package:ai_tutor_quiz/domain/entities/entities.dart';

import '../../models/gemini_response/gemini_msg_chat_response.dart';

const empty = "";
const zero = 0;

extension MessageResponseMapper on GeminiMsgResponse? {
  Message toDomain() {
    return Message(
      id: null,
      content: this?.response ?? empty,
      sender: SenderType.bot,
    );
  }
}
