part of 'chatroom_widget.dart';

class FileMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const FileMsg({
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
  State<FileMsg> createState() => _FileMsgState();
}

class _FileMsgState extends State<FileMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
