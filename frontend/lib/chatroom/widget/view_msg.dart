part of 'chatroom_widget.dart';

class ViewMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const ViewMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
  });

  @override
  State<ViewMsg> createState() => _ViewMsgState();
}

class _ViewMsgState extends State<ViewMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
