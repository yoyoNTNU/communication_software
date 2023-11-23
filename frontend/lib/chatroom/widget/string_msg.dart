part of 'chatroom_widget.dart';

class StringMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? messageID;
  final int? senderID;
  final bool isReply;
  final int? replyMsgID;
  final int? readCount;
  final String content;
  final String msgTime;
  final List<Map<String, dynamic>> memberInfos;
  final List<Map<String, dynamic>>? messageData;
  final void Function()? onLongPressed;
  final void Function(int)? jumpToReplyMsg;

  const StringMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.isReply,
    this.replyMsgID,
    required this.readCount,
    required this.content,
    required this.msgTime,
    this.onLongPressed,
    required this.messageID,
    required this.memberInfos,
    required this.messageData,
    required this.jumpToReplyMsg,
  });

  @override
  State<StringMsg> createState() => _StringMsgState();
}

class _StringMsgState extends State<StringMsg> {
  String read = "";
  RegExp urlRegex = RegExp(r'\b(?:https?://)[^\s]+');
  late final Iterable<RegExpMatch> matches;
  List<TextSpan> textSpans = [];
  int currentIndex = 0;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    matches = urlRegex.allMatches(widget.content);
    for (RegExpMatch match in matches) {
      textSpans.add(
        TextSpan(
          text: widget.content.substring(currentIndex, match.start),
          style: AppStyle.body(
              color: widget.senderIsMe ? AppStyle.white : AppStyle.gray[700]!),
        ),
      );
      textSpans.add(
        TextSpan(
          text: match.group(0),
          style: AppStyle.body(
                  color:
                      widget.senderIsMe ? AppStyle.white : AppStyle.blue[500]!)
              .copyWith(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchUrl(Uri.parse(match.group(0)!));
            },
        ),
      );

      currentIndex = match.end;
    }

    // Add the remaining text after the last URL
    textSpans.add(
      TextSpan(
        text: widget.content.substring(currentIndex),
        style: AppStyle.body(
            color: widget.senderIsMe ? AppStyle.white : AppStyle.gray[700]!),
      ),
    );

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (widget.senderIsMe) {
      String temp = readCount(widget.readCount, widget.chatroomType);
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
          int msgIndex = widget.messageData!.indexWhere(
              (element) => element["messageID"] == widget.replyMsgID);
          if (msgIndex != -1) {
            widget.jumpToReplyMsg!(widget.replyMsgID!);
          }
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
                  ReplyMsg(
                    replyMsgID: widget.replyMsgID,
                    senderIsMe: widget.senderIsMe,
                    memberInfos: widget.memberInfos,
                    messageData: widget.messageData,
                  ),
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
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: textSpans,
                      ),
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
