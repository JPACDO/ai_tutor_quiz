import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({required this.topicId, super.key});
  static const name = 'chat-screen';

  final String? topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Topic topic =
        ref.read(topicsProvider).firstWhere((element) => element.id == topicId);

    return Scaffold(
      appBar: AppBar(
        title: Text(topic.name),
      ),
      body: _ChatView(topic: topic),
    );
  }
}

class _ChatView extends ConsumerStatefulWidget {
  final Topic topic;

  const _ChatView({required this.topic});

  @override
  ConsumerState<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<_ChatView> {
  @override
  void initState() {
    super.initState();
    ref.read(chatProvider.notifier).loadTopic(topic: widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    final Topic chatTopic = ref.watch(chatProvider);

    final ScrollController chatsScrollController =
        ref.watch(chatScrollControllerProvider);

    final messagesList = chatTopic.messages.reversed.toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    reverse: true,
                    // keyboardDismissBehavior:
                    //     ScrollViewKeyboardDismissBehavior.onDrag,
                    controller: chatsScrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final message = messagesList[index];
                      if (message == null) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return (message.sender == SenderType.user)
                          ? MyMessageBubble(
                              message: message,
                              isLast: index == 0,
                              onResent: () {
                                final history = [...chatTopic.messages];
                                history.removeLast();
                                _sendToIA(
                                    'try to: ${message.content}',
                                    chatTopic.copyWith(messages: history),
                                    message.imgUrl);
                              })
                          : NoMyMessageBubble(message: message);
                    })),
            const SizedBox(height: 5),

            /// Caja de texto de mensajes
            MessageFieldBox(
              // onValue: (value) => chatProvider.sendMessage(value),
              onValue: (value, image) async {
                // value = value.trim();
                // if (value.isEmpty) return;
                final imagepath =
                    await ref.read(chatProvider.notifier).saveImageOfMessage(
                          img: image,
                        );
                ref.read(chatProvider.notifier).addMessage(
                    message: Message(
                        content: value,
                        sender: SenderType.user,
                        imgUrl: imagepath));

                await _sendToIA(value, chatTopic, imagepath);

                // await ref
                //     .read(topicsProvider.notifier)
                //     .updateTopic(topic: chatTopic);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _sendToIA(String value, Topic chatTopic, String? imagePath) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        await ref.read(chatProvider.notifier).getResponseMessage(
            prompt: value, topic: chatTopic, imgUrl: imagePath);
      }
    } on SocketException catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet connection'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
      // print('error');
      return;
    }
  }
}
