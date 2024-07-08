import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:image_picker/image_picker.dart';

abstract class MessageRepository {
  // API methods
  Future<Message?> getBotMessage(
      {required String prompt, String? imgUrl, required Topic topic});
  // Database methods
  Future<String> saveImageOfMessage({required XFile img});
  Future<bool> deleteMessage({required String id});
}
