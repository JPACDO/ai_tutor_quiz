import 'package:ai_tutor_quiz/config/constants/enviroment.dart';
import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';
import 'package:ai_tutor_quiz/infrastructure/mappers/chat/msg_mapper.dart';
import 'package:ai_tutor_quiz/infrastructure/models/gemini_response/gemini_msg_chat_response.dart';
import 'package:ai_tutor_quiz/presentation/providers/chat/chat_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model_provider.g.dart';

@Riverpod(keepAlive: true)
class chatStream extends _$chatStream {
  @override
  ChatSession build() {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: Env.geminiKey,
      generationConfig: GenerationConfig(
        temperature: 1.0,
        topK: 32,
        topP: 1,
      ),
    );
    return model.startChat(history: [
      // Content.text('Hello, I have 2 dogs in my house.'),
      // Content.model([TextPart('Great to meet you. What would you like to know?')])
    ]);
  }

  Future<Message?> getSimpleResponseStream(String entradaDeTexto) async {
    var content = Content.text(entradaDeTexto);

    var response = await state.sendMessage(content);
    state = state;
    print(state.history);

    print(response.text);
    final String jsonExtractor =
        '{"responseData":"${response.text!.replaceAll("\"", "\\\"").replaceAll("\n", "\\n")}", "suggestions": [], "resumenQuestion": "", "resumenAnswer": ""}';

    final geminiMsgResponse = geminiMsgResponseFromJson(jsonExtractor);

    return geminiMsgResponse.toDomain();
  }
}
