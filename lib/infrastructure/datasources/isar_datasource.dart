import 'dart:io';

import 'package:ai_tutor_quiz/infrastructure/errors/localdb_errors.dart';
import 'package:ai_tutor_quiz/infrastructure/mappers/mappers.dart';
import 'package:ai_tutor_quiz/infrastructure/models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import '../../domain/datasources/datasources.dart';

class IsarDatasource
    implements MessageDatasource, TopicDatasource, GroupQuestionsDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [TopicResponseLocalSchema, GroupQuestionsResponseLocalSchema],
        directory: dir.path,
      );
      return isar;
    }

    return Future.value(Isar.getInstance());
  }

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
  Future<bool> deleteTopic({required String id}) async {
    final isar = await db;
    bool success = false;
    final idParse = int.tryParse(id);
    if (idParse == null) throw NoIntegerException();
    return isar.writeTxn(() async {
      success = await isar.topicResponseLocals.delete(idParse);
      return success;
    });
  }

  @override
  Future<List<Topic>> getAllTopics(String userId) async {
    final isar = await db;
    final topics = await isar.topicResponseLocals.where().findAll();
    final List<Topic> listTopics = topics.map((e) => e.toDomain()).toList();
    return listTopics;
  }

  @override
  Future<Topic> addTopic({required Topic topic}) async {
    if (topic.id != null) throw IdNoNullException();

    final isar = await db;

    // Insertar
    final topicIn = TopicResponseLocal(
        createdAt: DateTime.now(),
        name: topic.name,
        userId: topic.userId,
        messages: []);

    await isar.writeTxn(() async {
      final resp = await isar.topicResponseLocals.put(topicIn);
      topicIn.isarId = resp;
    });
    return topicIn.toDomain();
  }

  @override
  Future<bool> updateTopic({required Topic topic}) async {
    final isar = await db;
    int? resp; // Insertar
    final topicIn = TopicResponseLocal(
      isarId: int.tryParse(topic.id!),
      name: topic.name,
      messages: topic.messages
          .map((e) => MessageResponseLocal()
            ..content = e?.content
            ..sender = e?.sender
            ..imgUrl = e?.imgUrl)
          .toList(),
    );

    await isar.writeTxn(() async {
      resp = await isar.topicResponseLocals.put(topicIn);
    });
    return topicIn.isarId == resp;
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
  Future<bool> deleteGroupQuestion({required String id}) async {
    final isar = await db;
    bool success = false;
    final idParse = int.tryParse(id);
    if (idParse == null) throw NoIntegerException();
    await isar.writeTxn(() async {
      success = await isar.groupQuestionsResponseLocals.delete(idParse);
    });
    return success;
  }

  @override
  Future<List<GroupQuestions>> getAllGroupQuestion(
      {required String userId}) async {
    final isar = await db;
    final groups = await isar.groupQuestionsResponseLocals.where().findAll();
    final List<GroupQuestions> listGroup =
        groups.map((e) => e.toDomain()).toList();
    return listGroup;
  }

  @override
  Future<GroupQuestions?> getGroupQuestion({required String id}) async {
    final isar = await db;
    final group = await isar.groupQuestionsResponseLocals
        .filter()
        .isarIdEqualTo(int.tryParse(id))
        .findFirst();
    if (group == null) throw NoFoundException(element: 'Group');
    return group.toDomain();
  }

  @override
  Future<GroupQuestions> newGroupQuestion(
      {required GroupQuestions group}) async {
    if (group.id != null) throw IdNoNullException();

    final isar = await db;

    // Insertar
    final groupIn = GroupQuestionsResponseLocal(
      name: group.name,
      description: group.description,
      questions: [],
      userId: group.userId,
    );

    await isar.writeTxn(() async {
      final resp = await isar.groupQuestionsResponseLocals.put(groupIn);
      groupIn.isarId = resp;
    });
    return groupIn.toDomain();
  }

  @override
  Future<bool> updateGroupQuestion({required GroupQuestions group}) async {
    final isar = await db;
    int? resp; // Insertar
    final groupIn = GroupQuestionsResponseLocal(
      isarId: int.tryParse(group.id!),
      name: group.name,
      description: group.description,
      userId: group.userId,
      questions: group.questions
          .map((e) => QuestionResponseLocal()
            ..id = e.id
            ..question = e.question
            ..correctAnswerIndex = e.correctAnswerIndex
            ..type = e.type
            ..alternatives = e.alternatives)
          .toList(),
    );

    await isar.writeTxn(() async {
      resp = await isar.groupQuestionsResponseLocals.put(groupIn);
    });
    return groupIn.isarId == resp;
  }

  @override
  Future<Question> addQuestionInGroup(
      {required String groupId, required Question question}) async {
    final groupDB = await getGroupQuestion(id: groupId);

    if (groupDB == null) throw NoFoundException();
    final newQuestion = question.copyWith(id: DateTime.now().toString());
    groupDB.questions.add(newQuestion);

    final resp = await updateGroupQuestion(group: groupDB);

    if (!resp) throw NoSaveException();

    return newQuestion;
  }

  @override
  Future<bool> deleteQuestionOfGroup(
      {required String groupId, required String questionId}) async {
    final groupDB = await getGroupQuestion(id: groupId);
    if (groupDB == null) throw NoFoundException(element: 'Group');

    final index =
        groupDB.questions.indexWhere((element) => element.id == questionId);

    if (index == -1) throw NoFoundException(element: 'Question');

    groupDB.questions.removeAt(index);

    return await updateGroupQuestion(group: groupDB);
  }
}
