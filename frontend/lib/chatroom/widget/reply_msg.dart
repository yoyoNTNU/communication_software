part of 'chatroom_widget.dart';

class ReplyMsg extends StatefulWidget {
  final int? replyMsgID;
  final bool senderIsMe;
  final List<Map<String, dynamic>> memberInfos;
  final List<Map<String, dynamic>>? messageData;
  //去撈資料

  const ReplyMsg({
    super.key,
    required this.replyMsgID,
    required this.senderIsMe,
    required this.memberInfos,
    required this.messageData,
  });

  @override
  State<ReplyMsg> createState() => _ReplyMsgState();
}

class _ReplyMsgState extends State<ReplyMsg> {
  final String msgType = "string";
  late final Map<String, dynamic> replyMsgData;
  String senderName = "";
  String content = "";

  @override
  void initState() {
    setReplyMsgData();
    super.initState();
  }

  void setReplyMsgData() async {
    if (widget.replyMsgID != null && widget.messageData != null) {
      int msgIndex = widget.messageData!
          .indexWhere((element) => element["messageID"] == widget.replyMsgID);
      if (msgIndex == -1) {
        setState(() {
          content = "訊息已被刪除";
        });
        return;
      }
      Map<String, dynamic> data = widget.messageData![msgIndex];
      if (!mounted) return;
      setState(() {
        replyMsgData = data;
        int index = widget.memberInfos
            .indexWhere((element) => element["id"] == data["senderID"]);
        senderName = widget.memberInfos[index]["name"];
        content = data["content"];
      });
    } else {
      setState(() {
        content = "訊息已被刪除";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: widget.senderIsMe ? AppStyle.white : AppStyle.blue[50]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 29,
                height: 18,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: widget.senderIsMe
                          ? AppStyle.blue[100]!
                          : AppStyle.blue[300]!),
                ),
                child: Text(
                  "回覆",
                  style: AppStyle.info(
                      level: 2,
                      color: widget.senderIsMe
                          ? AppStyle.blue[100]!
                          : AppStyle.blue[300]!),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                senderName,
                style: AppStyle.header(
                    level: 3,
                    color: widget.senderIsMe
                        ? AppStyle.white
                        : AppStyle.gray[700]!),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              msgType == "string" ? content : replyMsgMap(msgType),
              style: AppStyle.body(
                  color: widget.senderIsMe
                      ? AppStyle.gray[100]!
                      : AppStyle.gray[500]!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}

String replyMsgMap(String msgType) {
  String content;
  switch (msgType) {
    case "photo":
      content = "相片";
      break;
    case "video":
      content = "影片";
      break;
    case "file":
      content = "檔案";
      break;
    case "voice":
      content = "語音訊息";
      break;
    case "info":
      content = "聯絡資訊";
      break;
    default:
      content = "未知的類別";
      break;
  }
  return content;
}
