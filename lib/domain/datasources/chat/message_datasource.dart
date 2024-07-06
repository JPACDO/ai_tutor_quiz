import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

abstract class MessageDatasource {
  Future<Message?> getMessage(
      {required String prompt,
      required String? imgUrl,
      required List<Content> history});

  Future<String> saveImageOfMessage({required XFile img});
}
