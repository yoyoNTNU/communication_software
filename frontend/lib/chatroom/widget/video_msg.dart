part of 'chatroom_widget.dart';

class VideoMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const VideoMsg({
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
  State<VideoMsg> createState() => _VideoMsgState();
}

class _VideoMsgState extends State<VideoMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
