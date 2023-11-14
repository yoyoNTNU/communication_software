part of 'chatroom_widget.dart';

class StringMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? messageID;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final String content;
  final String msgTime;
  final void Function()? onLongPressed;

  const StringMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.isReply,
    this.replyMsgID,
    required this.content,
    required this.msgTime,
    this.onLongPressed,
    required this.messageID,
  });

  @override
  State<StringMsg> createState() => _StringMsgState();
}

class _StringMsgState extends State<StringMsg> {
  String read = "";

  @override
  void didChangeDependencies() async {
    if (widget.senderIsMe) {
      String temp = await readCount(widget.messageID, widget.chatroomType);
      if (!mounted) return;
      setState(() {
        read = temp;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (widget.isReply) {
          print("這邊應該要跳到回覆的那則訊息");
        }
      },
      onLongPress: widget.messageID == null ? null : widget.onLongPressed,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: screenWidth * 0.70, minWidth: 120),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.senderIsMe ? AppStyle.blue[400] : AppStyle.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isReply)
                  ReplyMsg(replyMsgID: 1, senderIsMe: widget.senderIsMe),
                Transform.translate(
                  offset: const Offset(0, -1),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 1,
                            color: widget.isReply
                                ? widget.senderIsMe
                                    ? AppStyle.white
                                    : AppStyle.blue[50]!
                                : Colors.transparent),
                      ),
                    ),
                    padding: EdgeInsets.only(top: widget.isReply ? 4 : 0),
                    child: Text(
                      widget.content,
                      style: AppStyle.body(
                          color: widget.senderIsMe
                              ? AppStyle.white
                              : AppStyle.gray[700]!),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                "$read${widget.msgTime}",
                style: AppStyle.info(
                    level: 2,
                    color: widget.senderIsMe
                        ? AppStyle.gray[100]!
                        : AppStyle.gray[500]!),
              ),
            )
          ],
        ),
      ),
    );
  }
}
