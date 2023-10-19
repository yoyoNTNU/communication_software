part of 'chatroom_widget.dart';

class MsgTile extends StatefulWidget {
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final bool isSelected;

  const MsgTile({
    super.key,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
    required this.isSelected,
  });

  @override
  State<MsgTile> createState() => _MsgTileState();
}

class _MsgTileState extends State<MsgTile> {
  //直接在這頁撈sender資訊
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      alignment:
          widget.senderIsMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        children: [
          if (!widget.senderIsMe)
            Container(
              alignment: Alignment.topCenter,
              width: 36,
              child: Image.asset("assets/images/avatar.png"),
            ),
          if (!widget.senderIsMe)
            const SizedBox(
              width: 8,
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.senderIsMe)
                Text(
                  "人名",
                  style: AppStyle.header(level: 3),
                ),
              if (!widget.senderIsMe)
                const SizedBox(
                  height: 4,
                ),
              classifyMsg(
                senderIsMe: widget.senderIsMe,
                senderID: widget.senderID,
                messageType: widget.messageType,
                isReply: widget.isReply,
                replyMsgID: widget.replyMsgID,
                content: widget.content,
              ),
              if (widget.isSelected)
                const SizedBox(
                  height: 4,
                ),
              if (widget.isSelected) SelectBar(senderIsMe: widget.senderIsMe),
            ],
          )
        ],
      ),
    );
  }
}
