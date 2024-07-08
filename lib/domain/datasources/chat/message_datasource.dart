import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:image_picker/image_picker.dart';

abstract class MessageDatasource {
  Future<Message?> getMessage(
      {required String prompt, required String? imgUrl, required Topic topic});

  Future<String> saveImageOfMessage({required XFile img});
}
