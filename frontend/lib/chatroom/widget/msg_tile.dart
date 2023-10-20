part of 'chatroom_widget.dart';

class MsgTile extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;
  final bool setAllDisSelected;
  final int index;
  final int? tileIsSelectedIndex;
  final void Function(bool, int?) setScreenOnTapAndSelectedIndex;

  const MsgTile({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.messageType,
    required this.isReply,
    this.replyMsgID,
    required this.content,
    required this.msgTime,
    required this.setAllDisSelected,
    this.tileIsSelectedIndex,
    required this.index,
    required this.setScreenOnTapAndSelectedIndex,
  });

  @override
  State<MsgTile> createState() => _MsgTileState();
}

class _MsgTileState extends State<MsgTile> {
  //直接在這頁撈sender資訊
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    if (widget.setAllDisSelected) {
      setState(() {
        isSelected = widget.index == widget.tileIsSelectedIndex ? true : false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.setScreenOnTapAndSelectedIndex(
            false, isSelected ? widget.index : -1);
      });
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      alignment:
          widget.senderIsMe ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
          color: isSelected ? AppStyle.blue[100]! : AppStyle.blue[50]!,
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: AppStyle.blue),
                  top: BorderSide(color: AppStyle.blue),
                )
              : Border.all(color: Colors.transparent)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                chatroomType: widget.chatroomType,
                senderIsMe: widget.senderIsMe,
                senderID: widget.senderID,
                messageType: widget.messageType,
                isReply: widget.isReply,
                replyMsgID: widget.replyMsgID,
                content: widget.content,
                msgTime: widget.msgTime,
                onLongPressed: () {
                  setState(() {
                    isSelected = true;
                  });
                  widget.setScreenOnTapAndSelectedIndex(true, widget.index);
                },
              ),
              if (isSelected)
                const SizedBox(
                  height: 4,
                ),
              if (isSelected) SelectBar(senderIsMe: widget.senderIsMe),
            ],
          )
        ],
      ),
    );
  }
}
