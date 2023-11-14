part of 'chatroom_widget.dart';

class CallMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? messageID;
  final int? senderID;
  final String content;
  final String msgTime;

  const CallMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.content,
    required this.msgTime,
    required this.messageID,
  });

  @override
  State<CallMsg> createState() => _CallMsgState();
}

class _CallMsgState extends State<CallMsg> {
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
        print("開始語音通話");
        //TODO:開始語音通話
      },
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
                Container(
                  width: 29,
                  height: 18,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: widget.senderIsMe
                            ? widget.content == "00:00:00"
                                ? const Color(0xFFFFE7E6)
                                : AppStyle.gray[100]!
                            : widget.content == "00:00:00"
                                ? const Color(0xFFFD9E9B)
                                : AppStyle.teal),
                  ),
                  child: Text(
                    "通話",
                    style: AppStyle.info(
                        level: 2,
                        color: widget.senderIsMe
                            ? widget.content == "00:00:00"
                                ? const Color(0xFFFFE7E6)
                                : AppStyle.gray[100]!
                            : widget.content == "00:00:00"
                                ? const Color(0xFFFD9E9B)
                                : AppStyle.teal),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.senderIsMe
                          ? widget.content == "00:00:00"
                              ? Image.asset(
                                  "assets/icons/call_fail_light_pink.png")
                              : Image.asset("assets/icons/call_white.png")
                          : widget.content == "00:00:00"
                              ? Image.asset("assets/icons/call_fail_pink.png")
                              : Image.asset("assets/icons/call.png"),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.content == "00:00:00"
                                ? widget.senderIsMe
                                    ? "無人回應"
                                    : "未接來電"
                                : "語音通話已結束",
                            style: AppStyle.body(
                                color: widget.senderIsMe
                                    ? widget.content == "00:00:00"
                                        ? const Color(0xFFFFE7E6)
                                        : AppStyle.gray[100]!
                                    : widget.content == "00:00:00"
                                        ? const Color(0xFFFD9E9B)
                                        : AppStyle.teal),
                          ),
                          if (widget.content != "00:00:00")
                            Text(
                              "通話時間 ${timeTrans(widget.content)}",
                              style: AppStyle.info(
                                  level: 2,
                                  color: widget.senderIsMe
                                      ? AppStyle.gray[100]!
                                      : AppStyle.gray[500]!),
                            )
                        ],
                      )
                    ],
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
