part of 'chatroom_widget.dart';

class ReplyMsg extends StatefulWidget {
  final int replyMsgID;
  final bool senderIsMe;
  //去撈資料

  const ReplyMsg({
    super.key,
    required this.replyMsgID,
    required this.senderIsMe,
  });

  @override
  State<ReplyMsg> createState() => _ReplyMsgState();
}

class _ReplyMsgState extends State<ReplyMsg> {
  final String msgType = "string";
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
                "Adam",
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
              msgType == "string" ? "回覆訊息測試" : replyMsgMap(msgType), //要將6種做分類
              style: AppStyle.body(
                  color: widget.senderIsMe
                      ? AppStyle.gray[100]!
                      : AppStyle.gray[500]!),
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
