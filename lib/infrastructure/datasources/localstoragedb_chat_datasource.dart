import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import '../../domain/datasources/datasources.dart';

class LocalStorageDbChatDatasource
    implements MessageDatasource, TopicDatasource, GroupQuestionsDatasource {
  // MessageDatasource
  @override
  Future<Message?> getMessage(
      {required String prompt, required String? imgUrl, required Topic topic}) {
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
  Future<bool> deleteAllMessagesOfTopic({required String topicId}) {
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
  Future<bool> updateTopic({required Topic topic}) {
    // TODO: implement updateTopic
    throw UnimplementedError();
  }

  @override
  Future<Topic> getTopic({required String topicId}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAllGroupQuestion({required String userId}) {
    // TODO: implement deleteAllGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteGroupQuestion({required String id}) {
    // TODO: implement deleteGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<List<GroupQuestions>> getAllGroupQuestion({required String userId}) {
    // TODO: implement getAllGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<GroupQuestions> getGroupQuestion({required String id}) {
    // TODO: implement getGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<GroupQuestions> newGroupQuestion({required GroupQuestions group}) {
    // TODO: implement saveGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<bool> updateGroupQuestion({required GroupQuestions group}) {
    // TODO: implement updateGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<bool> addQuestionInGroup(
      {required String groupId, required Question question}) {
    // TODO: implement addQuestiontoGroup
    throw UnimplementedError();
  }
}
