import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/use_cases/use_case.dart';
import 'package:ai_tutor_quiz/infrastructure/repositories/repositories.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

part 'chat_provider.g.dart';

// --  MESSAGE PROVIDER  --

@riverpod
MessageRepositoryImpl messageRepository(MessageRepositoryRef ref) {
  final geminiChatDatasource = ref.read(geminiChatDatasourceProvider);
  final localStorageDbChatDatasource =
      ref.read(localStorageDbChatDatasourceProvider);
  return MessageRepositoryImpl(
      geminiChatDatasource, localStorageDbChatDatasource);
}

@riverpod
GetBotMessageUseCase getBotMessage(GetBotMessageRef ref) {
  final messageRepository = ref.read(messageRepositoryProvider);
  return GetBotMessageUseCase(messageRepository);
}

// --  CHAT PROVIDER  --

@riverpod
class Chat extends _$Chat {
  @override
  Topic build() {
    return Topic(idDb: '1', name: '', messages: []);
  }

  void loadTopic({required Topic topic}) async {
    state = await Future.value(topic);
  }

  void addMessage({required Message? message}) {
    if (state.messages.isEmpty) {
      state = state.copyWith(messages: [message]);
    }
    if (message != state.messages.last) {
      state = state.copyWith(messages: [...state.messages, message]);
    }
    if (message != null) {
      ref.read(topicsProvider.notifier).updateTopic(topic: state);
    }
  }

  void loadingResponse() {
    addMessage(message: null);
  }

  void removeLastMessage() {
    if (state.messages.isEmpty) return;
    state = state.copyWith(
        messages: state.messages.sublist(0, state.messages.length - 1));
  }

  Future<void> getResponseMessage(
      {required String prompt, String? imgUrl, required Topic topic}) async {
    // //////// GUARDAR IMAGEN ANTES DE ENVIAR MENSAJE EN EL CODIGO SCREEN
    // addMessage(
    //     message: Message(
    //         id: '1', content: prompt, sender: SenderType.user, imgUrl: imgUrl));
    // final chatsesson = ref.read(chatStreamProvider);

    loadingResponse();
    ref.read(chatScrollControllerProvider.notifier).moveScrollToBottom();

    final message = await ref
        .read(getBotMessageProvider) // useCase  getBotMessage
        .call(data: prompt, imgUrl: imgUrl, topic: topic);

    // final message = await ref
    //     .read(chatStreamProvider.notifier)
    //     .getSimpleResponseStream(prompt);
    removeLastMessage();
    if (message == null) return;

    addMessage(message: message);
    ref.read(chatScrollControllerProvider.notifier).moveScrollToBottom();
  }

  Future<String?> saveImageOfMessage({required XFile? img}) async {
    if (img == null) return null;

    return await ref
        .read(localStorageDbChatDatasourceProvider)
        .saveImageOfMessage(img: img);
  }
}

@riverpod
class ChatScrollController extends _$ChatScrollController {
  @override
  ScrollController build() {
    return ScrollController();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    // state.animateTo(state.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    state.animateTo(state.position.minScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
