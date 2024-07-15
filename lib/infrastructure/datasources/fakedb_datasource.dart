import 'dart:io';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';
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

final dbGroups = <GroupQuestions>[
  GroupQuestions(
    idDb: '1',
    name: 'Group 1',
    description: 'Description 1',
    questions: [
      Question(
          question: 'Question 1',
          alternatives: ['Answer 1', 'Answer 2', 'Answer 3'],
          correctAnswerIndex: 1,
          type: QuizType.multipleChoice),
      Question(
          question: 'Question 2',
          alternatives: ['Answer 1', 'Answer 2'],
          correctAnswerIndex: 1,
          type: QuizType.trueFalse),
      Question(
          question: 'Question 3',
          alternatives: ['Answer 1', 'Answer 2', 'Answer 3'],
          correctAnswerIndex: 0,
          type: QuizType.openAnswer),
    ],
  ),
  GroupQuestions(
    idDb: '2',
    name: 'Group 2',
    description: 'Description 2',
    questions: [],
  ),
];

class FakeDbDatasource extends LocalStorageDbChatDatasource {
  // MESSAGE ----------------------------------------------------------------------
  @override
  Future<Message?> getMessage(
      {required String prompt, required String? imgUrl, Topic? topic}) {
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

  // TOPICS -----------------------------------------------------------------------
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
    dbTopics.removeWhere((element) => element.idDb == id);
    return Future.value(true);
  }

  @override
  Future<List<Topic>> getAllTopics(String userId) {
    return Future.value(dbTopics);
  }

  @override
  Future<Topic> getTopic({required String topicId}) {
    final topic = dbTopics.firstWhere((element) => element.idDb == topicId);
    return Future.value(topic);
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
  Future<bool> updateTopic({required Topic topic}) {
    // print(topic.messages);
    final index = dbTopics.indexWhere((element) => element.idDb == topic.idDb);
    dbTopics[index] = topic;
    return Future.value(true);
  }

  // GROUP OF QUESTIONS -----------------------------------------------------------
  @override
  Future<bool> deleteAllGroupQuestion({required String userId}) {
    // TODO: implement deleteAllGroupQuiz
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteGroupQuestion({required String id}) {
    dbGroups.removeWhere((element) => element.idDb == id);
    return Future.value(true);
  }

  @override
  Future<List<GroupQuestions>> getAllGroupQuestion({required String userId}) {
    return Future.value(dbGroups);
  }

  @override
  Future<GroupQuestions> getGroupQuestion({required String id}) {
    final group = dbGroups.firstWhere((element) => element.idDb == id);
    return Future.value(group);
  }

  @override
  Future<bool> newGroupQuestion({required GroupQuestions group}) {
    if (group.idDb != null) {
      throw Exception('ID debe ser nulo o no existir');
    }
    final newGroup = group.copyWith(idDb: DateTime.now().toString());
    dbGroups.add(newGroup);
    return Future.value(true);
  }

  @override
  Future<bool> updateGroupQuestion({required GroupQuestions group}) {
    final index = dbGroups.indexWhere((element) => element.idDb == group.idDb);
    dbGroups[index] = group;
    return Future.value(true);
  }

  @override
  Future<bool> addQuestionInGroup(
      {required String groupId, required Question question}) {
    final group = dbGroups.firstWhere((element) => element.idDb == groupId);
    group.questions.add(question);
    dbGroups[dbGroups.indexOf(group)] = group;
    return Future.value(true);
  }
}
