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
  final int? index;
  final int? tileIsSelectedIndex;
  final void Function(bool, int?) setScreenOnTapAndSelectedIndex;
  final List<Map<String, dynamic>> memberInfos;
  final VoidCallback cancelSelected;
  final void Function(int) setAnnounce;
  final void Function(int) deleteMessage;

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
    this.index,
    required this.setScreenOnTapAndSelectedIndex,
    required this.memberInfos,
    required this.cancelSelected,
    required this.setAnnounce,
    required this.deleteMessage,
  });

  @override
  State<MsgTile> createState() => _MsgTileState();
}

class _MsgTileState extends State<MsgTile> {
  bool isSelected = false;
  String senderName = "";
  String? senderAvatar;

  int getIndex(int senderID) {
    int index = widget.memberInfos.indexWhere((element) {
      if (element["id"] == senderID) {
        return true;
      }
      return false;
    });
    return index;
  }

  @override
  void initState() {
    int index = getIndex(widget.senderID!);
    if (!mounted) return;
    setState(() {
      senderName = widget.senderIsMe
          ? ""
          : index == -1
              ? ""
              : widget.memberInfos[index]["name"];
      senderAvatar = widget.senderIsMe
          ? null
          : index == -1
              ? null
              : widget.memberInfos[index]["avatar"];
    });

    super.initState();
  }

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
        crossAxisAlignment: widget.senderIsMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (widget.index == null)
            const SizedBox(
              width: 4,
            ),
          if (widget.index == null)
            Image.asset(
              "assets/icons/sending.png",
              width: 12,
              height: 12,
            ),
          if (!widget.senderIsMe)
            Container(
              alignment: Alignment.topCenter,
              width: 36,
              child: ClipOval(
                clipBehavior: Clip.hardEdge,
                child: senderAvatar != null
                    ? Image.network(senderAvatar!)
                    : Image.asset("assets/images/avatar.png"),
              ),
            ),
          if (!widget.senderIsMe)
            const SizedBox(
              width: 8,
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.senderIsMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!widget.senderIsMe)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    senderName,
                    style: AppStyle.header(level: 3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (!widget.senderIsMe)
                const SizedBox(
                  height: 4,
                ),
              classifyMsg(
                chatroomType: widget.chatroomType,
                senderIsMe: widget.senderIsMe,
                messageID: widget.index,
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
              if (isSelected && widget.index != null)
                SelectBar(
                  senderIsMe: widget.senderIsMe,
                  messageType: widget.messageType,
                  messageID: widget.index!,
                  cancelSelected: widget.cancelSelected,
                  content: widget.content,
                  setAnnounce: widget.setAnnounce,
                  deleteMessage: widget.deleteMessage,
                ),
            ],
          )
        ],
      ),
    );
  }
}
