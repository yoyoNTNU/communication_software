part of 'chatroom_widget.dart';

class FileMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const FileMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
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
