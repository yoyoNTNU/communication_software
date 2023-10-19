part of 'chatroom_widget.dart';

class PhotoMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const PhotoMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
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
