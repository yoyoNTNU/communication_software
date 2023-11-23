part of 'chatroom_widget.dart';

class InfoMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? messageID;
  final int? senderID;
  final int? readCount;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const InfoMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.readCount,
    required this.isReply,
    this.replyMsgID,
    required this.content,
    required this.msgTime,
    required this.messageID,
  });

  @override
  State<InfoMsg> createState() => _InfoMsgState();
}

class _InfoMsgState extends State<InfoMsg> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
