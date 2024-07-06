import 'dart:io';

import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';
import 'package:ai_tutor_quiz/domain/entities/chat/topic.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/datasources/datasources.dart';

class LocalStorageDbChatDatasource
    implements MessageDatasource, TopicDatasource {
  // MessageDatasource
  @override
  Future<Message?> getMessage(
      {required String prompt,
      required String? imgUrl,
      required List<Content> history}) {
    throw UnimplementedError();
  }

  @override
  Future<String> saveImageOfMessage({required XFile img}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final name = DateTime.now().toString();
    final imagePath = File('${directory.path}/$name.png');
    await imagePath.writeAsBytes(await img.readAsBytes());

    return imagePath.path;
  }

  // TopicDatasource
  @override
  Future<bool> deleteAllTopicMessages({required String topicId}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAllTopics(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTopic({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTopicMessage(
      {required String topicId, required String messageId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Topic>> getAllTopics(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<Topic> addTopic({required Topic topic}) async {
    // ID debe ser nulo o no existir
    // TODO:  IMPREMENTAR ESTE METODO PARA ALMACENAR EN UNA BASE DE DATOS LOCAL
    if (topic.idDb != null) {
      throw Exception('ID debe ser nulo o no existir');
    }
    return Topic(idDb: 'idDb', name: 'name', messages: []);
  }

  @override
  Future<bool> saveTopicMessage(
      {required String topicId, required String messageId}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTopic({required Topic topic}) {
    // TODO: implement updateTopic
    throw UnimplementedError();
  }

  @override
  Future<Topic> getTopic({required String topicId}) {
    throw UnimplementedError();
  }
}
