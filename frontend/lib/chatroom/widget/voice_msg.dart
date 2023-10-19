part of 'chatroom_widget.dart';

class VoiceMsg extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;

  const VoiceMsg({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
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
