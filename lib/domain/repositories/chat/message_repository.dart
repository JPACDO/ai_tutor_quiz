import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

abstract class MessageRepository {
  // API methods
  Future<Message?> getBotMessage(
      {required String prompt, String? imgUrl, required List<Content> history});
  // Database methods
  Future<String> saveImageOfMessage({required XFile img});
  Future<bool> deleteMessage({required String id});
}
