part of 'chatroom_widget.dart';

class VoiceMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;

  const VoiceMsg({
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
  State<VoiceMsg> createState() => _VoiceMsgState();
}

class _VoiceMsgState extends State<VoiceMsg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
