import 'dart:io';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final dbTopics = <Topic>[
  Topic(id: '1', name: 'Topic 1', userId: '0', messages: [
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
  Topic(id: '2', name: 'Topic 1', messages: [], userId: '0'),
  Topic(id: '3', name: 'Topic 1', messages: [], userId: '0'),
];

final dbGroups = <GroupQuestions>[
  GroupQuestions(
    id: '1',
    name: 'Group 1',
    description: 'Description 1',
    userId: '0',
    questions: [
      Question(
          id: '1',
          question: 'Question 1',
          alternatives: ['Answer 1', 'Answer 2', 'Answer 3'],
          correctAnswerIndex: 1,
          type: QuizType.multipleChoice),
      Question(
          id: '2',
          question: 'Question 2',
          alternatives: ['Answer 1', 'Answer 2'],
          correctAnswerIndex: 1,
          type: QuizType.trueFalse),
      Question(
          id: '3',
          question: 'Question 3',
          alternatives: ['Answer 1', 'Answer 2', 'Answer 3'],
          correctAnswerIndex: 0,
          type: QuizType.openAnswer),
    ],
  ),
  GroupQuestions(
    id: '2',
    name: 'Group 2',
    description: 'Description 2',
    questions: [],
    userId: '0',
  ),
];

class FakeDbDatasource extends IsarDatasource {
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
    dbTopics.removeWhere((element) => element.id == id);
    return Future.value(true);
  }

  @override
  Future<List<Topic>> getAllTopics(String userId) {
    return Future.value([...dbTopics]);
  }

  @override
  Future<Topic> getTopic({required String topicId}) {
    final topic = dbTopics.firstWhere((element) => element.id == topicId);
    return Future.value(topic);
  }

  @override
  Future<Topic> addTopic({required Topic topic}) {
    if (topic.id != null) {
      throw Exception('ID debe ser nulo o no existir');
    }
    final newTopic = topic.copyWith(id: DateTime.now().toString());
    dbTopics.add(newTopic);
    return Future.value(newTopic);
  }

  @override
  Future<bool> updateTopic({required Topic topic}) {
    // print(topic.messages);
    final index = dbTopics.indexWhere((element) => element.id == topic.id);
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
    dbGroups.removeWhere((element) => element.id == id);
    return Future.value(true);
  }

  @override
  Future<List<GroupQuestions>> getAllGroupQuestion({required String userId}) {
    return Future.value([...dbGroups.map((e) => e.copyWith(id: e.id))]);
  }

  @override
  Future<GroupQuestions> getGroupQuestion({required String id}) {
    final group = dbGroups.firstWhere((element) => element.id == id);
    return Future.value(group);
  }

  @override
  Future<GroupQuestions> newGroupQuestion({required GroupQuestions group}) {
    if (group.id != null) {
      throw Exception('ID debe ser nulo o no existir');
    }
    final newGroup = group.copyWith(id: DateTime.now().toString());
    dbGroups.add(newGroup);
    return Future.value(newGroup);
  }

  @override
  Future<bool> updateGroupQuestion({required GroupQuestions group}) {
    final index = dbGroups.indexWhere((element) => element.id == group.id);
    dbGroups[index] = group;
    return Future.value(true);
  }

  @override
  Future<Question> addQuestionInGroup(
      {required String groupId, required Question question}) {
    if (question.id != null) {
      throw Exception('ID question debe ser nulo o no existir');
    }

    final group = dbGroups.firstWhere((element) => element.id == groupId);
    final newQuestion = question.copyWith(id: DateTime.now().toString());
    group.questions.add(newQuestion);
    dbGroups[dbGroups.indexOf(group)] = group;
    return Future.value(newQuestion);
  }

  @override
  Future<bool> deleteQuestionOfGroup(
      {required String groupId, required String questionId}) {
    try {
      final group = dbGroups.firstWhere((element) => element.id == groupId);
      group.questions.removeWhere((element) => element.id == questionId);
      dbGroups[dbGroups.indexOf(group)] = group;
      return Future.value(true);
    } catch (e) {
      rethrow;
    }
  }
}
