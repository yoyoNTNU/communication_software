part of 'chatroom_widget.dart';

class MsgTile extends StatefulWidget {
  final GlobalKey msgKey;
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final String messageType;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;
  final bool setAllDisSelected;
  final int? readCount;
  final int? index;
  final int? tileIsSelectedIndex;
  final bool? isWidgetShake;
  final void Function(bool, int?) setScreenOnTapAndSelectedIndex;
  final List<Map<String, dynamic>> memberInfos;
  final List<Map<String, dynamic>>? messageData;
  final VoidCallback cancelSelected;
  final void Function(int) setAnnounce;
  final void Function(int) deleteMessage;
  final void Function(int) setReplyMsgID;

  const MsgTile({
    super.key,
    required this.msgKey,
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
    required this.isWidgetShake,
    required this.readCount,
    required this.setScreenOnTapAndSelectedIndex,
    required this.memberInfos,
    required this.cancelSelected,
    required this.setAnnounce,
    required this.deleteMessage,
    required this.setReplyMsgID,
    required this.messageData,
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

  void setSenderNameAndAvatar() {
    int index = getIndex(widget.senderID!);
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
  }

  @override
  void initState() {
    setState(() {
      setSenderNameAndAvatar();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setSenderNameAndAvatar();
    if (widget.setAllDisSelected) {
      setState(() {
        isSelected = widget.index == widget.tileIsSelectedIndex ? true : false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.setScreenOnTapAndSelectedIndex(
            false, isSelected ? widget.index : -1);
      });
    }
    return ShakeWidget(
      shakeConstant: ShakeHorizontalConstant1(),
      enableWebMouseHover: false,
      autoPlay: widget.isWidgetShake ?? false,
      child: Container(
        key: widget.msgKey,
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
              Image.asset(
                "assets/icons/sending.png",
                width: 12,
                height: 12,
              ),
            if (widget.index == null)
              const SizedBox(
                width: 4,
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
                  readCount: widget.readCount,
                  content: widget.content,
                  msgTime: widget.msgTime,
                  messageData: widget.messageData,
                  onLongPressed: () {
                    setState(() {
                      isSelected = true;
                    });
                    widget.setScreenOnTapAndSelectedIndex(true, widget.index);
                  },
                  memberInfos: widget.memberInfos,
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
                    setReplyMsgID: widget.setReplyMsgID,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
