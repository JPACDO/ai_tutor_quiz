enum SenderType { user, bot }

class Message {
  String content;
  SenderType sender;

  Message({required this.content, required this.sender});
}
