enum SenderType { user, bot }

class Message {
  String? id;
  String content;
  String? imgUrl;
  SenderType sender;

  Message(
      {required this.id,
      required this.content,
      required this.sender,
      this.imgUrl});

  copyWith({String? id, String? content, String? imgUrl, SenderType? sender}) {
    return Message(
        id: id ?? this.id,
        content: content ?? this.content,
        sender: sender ?? this.sender,
        imgUrl: imgUrl ?? this.imgUrl);
  }
}
