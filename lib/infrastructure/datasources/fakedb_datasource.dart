import 'dart:io';

import 'package:ai_tutor_quiz/domain/entities/chat/message.dart';

import 'package:ai_tutor_quiz/domain/entities/chat/topic.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final dbTopics = <Topic>[
  Topic(idDb: '1', name: 'Topic 1', messages: [
    Message(
      id: '1',
      content: "Hello, how are you?",
      sender: SenderType.user,
    ),
    Message(
      id: '2',
      content: "Good",
      sender: SenderType.bot,
    ),
    Message(
      id: '3',
      content: """

      I am fine.
      def
      fewf
      fwe
      f
      ew
      few
      f
      ewf
      ew
      f
      ewf
      ew
      f
      ewf
      ew
      f
      wef
      ew
      f
      we
      fwe
      f
      ew
      fwe
      f
      we
      few
      f
      we
      f
      wef
      we
      f
      wef
      we
      f
      ewf
      ew
      f
      ews
      """,
      sender: SenderType.user,
    ),
  ]),
  Topic(idDb: '2', name: 'Topic 1', messages: []),
  Topic(idDb: '3', name: 'Topic 1', messages: []),
];

class FakeDbDatasource extends LocalStorageDbChatDatasource {
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
    dbTopics.removeWhere((element) => element.idDb == id);
    return Future.value(true);
  }

  @override
  Future<bool> deleteTopicMessage(
      {required String topicId, required String messageId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Topic>> getAllTopics(String userId) {
    print("CARGARRRRRR TOPIC DB");
    return Future.value(dbTopics);
  }

  @override
  Future<Message?> getMessage(
      {required String prompt,
      required String? imgUrl,
      List<Content>? history}) {
    throw UnimplementedError();
  }

  @override
  Future<Topic> getTopic({required String topicId}) {
    final topic = dbTopics.firstWhere((element) => element.idDb == topicId);
    return Future.value(topic);
  }

  @override
  Future<String> saveImageOfMessage({required XFile img}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final name = DateTime.now().toString();
    final imagePath = File('${directory.path}/$name.png');
    await imagePath.writeAsBytes(await img.readAsBytes());

    return imagePath.path;
  }

  @override
  Future<Topic> addTopic({required Topic topic}) {
    if (topic.idDb != null) {
      throw Exception('ID debe ser nulo o no existir');
    }
    final newTopic = topic.copyWith(idDb: DateTime.now().toString());
    dbTopics.add(newTopic);
    return Future.value(newTopic);
  }

  @override
  Future<bool> saveTopicMessage(
      {required String topicId, required String messageId}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTopic({required Topic topic}) {
    // print(topic.messages);
    final index = dbTopics.indexWhere((element) => element.idDb == topic.idDb);
    dbTopics[index] = topic;
    return Future.value(true);
  }
}
