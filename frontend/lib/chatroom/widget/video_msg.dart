part of 'chatroom_widget.dart';

class VideoMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const VideoMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
  });

  @override
  State<VideoMsg> createState() => _VideoMsgState();
}

class _VideoMsgState extends State<VideoMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
