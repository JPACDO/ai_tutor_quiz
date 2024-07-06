import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';
import '../../../domain/repositories/repositories.dart';

class MessageRepositoryImpl extends MessageRepository {
  final GeminiChatDatasource _geminiChatDatasource;
  final LocalStorageDbChatDatasource _localStorageDbChatDatasource;

  MessageRepositoryImpl(
      this._geminiChatDatasource, this._localStorageDbChatDatasource);

  @override
  Future<bool> deleteMessage({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Message?> getBotMessage(
      {required String prompt,
      String? imgUrl,
      required List<Content> history}) async {
    return await _geminiChatDatasource.getMessage(
        prompt: prompt, imgUrl: imgUrl, history: history);
  }

  @override
  Future<String> saveImageOfMessage({required XFile img}) async {
    return await _localStorageDbChatDatasource.saveImageOfMessage(img: img);
  }
}
