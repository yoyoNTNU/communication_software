part of 'chatroom_widget.dart';

class CallMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const CallMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.isReply,
    this.replyMsgID,
    required this.content,
    required this.msgTime,
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
