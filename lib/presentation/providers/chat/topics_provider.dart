import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/use_cases/use_case.dart';
import 'package:ai_tutor_quiz/infrastructure/repositories/repositories.dart';
import 'package:ai_tutor_quiz/presentation/providers/database/databases_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topics_provider.g.dart';

// REPOSITORY PROVIDER  -----------------------------------------------------

@riverpod
TopicRepositoryImpl topicRepository(TopicRepositoryRef ref) {
  final localStorageDbChatDatasource = ref.read(fakeDatasourceProvider);
  return TopicRepositoryImpl(localStorageDbChatDatasource);
}

// USECASE PROVIDER  ---------------------------------------------------------

@riverpod
GetAllTopicsUseCase getAllTopics(GetAllTopicsRef ref) {
  final topicRepository = ref.read(topicRepositoryProvider);
  return GetAllTopicsUseCase(topicRepository);
}

@riverpod
AddNewTopicsUseCase addNewTopic(AddNewTopicRef ref) {
  final topicRepository = ref.read(topicRepositoryProvider);
  return AddNewTopicsUseCase(topicRepository);
}
// -- ALL TOPICs PROVIDER  --

@riverpod
class Topics extends _$Topics {
  @override
  List<Topic> build() {
    return [];
  }

  void getAllTopics({required String userId}) async {
    // es necesario el spread porque sino cuando lo llamo en addtopic
    // state es una funcion await por lo que lo llama y solo cuando le añado el nuevo topic
    // se vuelve una lista, por eso es que aparece un Topic de mas que es la BD cargada + el nuevo
    state = [...await ref.read(getAllTopicsProvider)(data: userId)];
  }

  void addTopic({required Topic topic}) async {
    try {
      final newTopic = await ref.read(addNewTopicProvider).call(data: topic);
      // final newTopic =
      //     await ref.read(topicRepositoryProvider).addNewTopic(topic: topic);
      state = [...state, newTopic];
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  Future<void> updateTopic({required Topic topic}) async {
    await ref.read(topicRepositoryProvider).updateTopic(topic: topic);
    state = state
        .map((element) => element.idDb == topic.idDb ? topic : element)
        .toList();
  }

  void removeTopic({required Topic topic}) {
    ref.read(topicRepositoryProvider).deleteTopic(id: topic.idDb!);
    state = state.where((element) => element.idDb != topic.idDb).toList();
  }

  Future<Topic> getTopic({required String topicId}) async {
    return await ref.read(topicRepositoryProvider).getTopic(topicId: topicId);
  }
}
