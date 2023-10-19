part of 'chatroom_widget.dart';

class StringMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const StringMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
  });

  @override
  State<StringMsg> createState() => _StringMsgState();
}

class _StringMsgState extends State<StringMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
