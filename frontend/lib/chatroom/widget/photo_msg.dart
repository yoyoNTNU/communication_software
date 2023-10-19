part of 'chatroom_widget.dart';

class PhotoMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const PhotoMsg({
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
  State<PhotoMsg> createState() => _PhotoMsgState();
}

class _PhotoMsgState extends State<PhotoMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
