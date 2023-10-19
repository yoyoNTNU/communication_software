part of 'chatroom_widget.dart';

class CallMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const CallMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
  });

  @override
  State<CallMsg> createState() => _CallMsgState();
}

class _CallMsgState extends State<CallMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
