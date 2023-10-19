part of 'chatroom_widget.dart';

class InfoMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const InfoMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
  });

  @override
  State<InfoMsg> createState() => _InfoMsgState();
}

class _InfoMsgState extends State<InfoMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
