part of 'chatroom_widget.dart';

class ReplyMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const ReplyMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
  });

  @override
  State<ReplyMsg> createState() => _ReplyMsgState();
}

class _ReplyMsgState extends State<ReplyMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
