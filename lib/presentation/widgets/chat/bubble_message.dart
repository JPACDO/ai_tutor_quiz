import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final Message message;

  const BubbleMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.sender == SenderType.user;
    return Container(
      child: isMe ? _myMessage() : _noMyMessage(),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(message.content),
        ),
      ),
    );
  }

  Widget _noMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          left: 5,
          bottom: 5,
          right: 50,
        ),
        child: Text(
          message.content,
        ),
      ),
    );
  }
}
