part of 'chatroom_widget.dart';

class ViewMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const ViewMsg({
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
  State<ViewMsg> createState() => _ViewMsgState();
}

class _ViewMsgState extends State<ViewMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
