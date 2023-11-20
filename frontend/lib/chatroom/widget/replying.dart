part of 'chatroom_widget.dart';

class Replying extends StatefulWidget {
  final List<Map<String, dynamic>> memberInfos;
  final List<Map<String, dynamic>> messageData;
  final int msgID;
  final VoidCallback cancelReply;

  const Replying({
    super.key,
    required this.memberInfos,
    required this.messageData,
    required this.msgID,
    required this.cancelReply,
  });

  @override
  State<Replying> createState() => _ReplyingState();
}

class _ReplyingState extends State<Replying> {
  String senderName = "";
  String? senderAvatar;
  int senderID = 0;
  String content = "";
  int msgIndex = 0;

  int getIndex() {
    int index = widget.memberInfos.indexWhere((element) {
      if (element["id"] == senderID) {
        return true;
      }
      return false;
    });
    return index;
  }

  void setSenderNameAndAvatar() {
    int index = getIndex();
    senderName = index == -1 ? "" : widget.memberInfos[index]["name"];
    senderAvatar = index == -1 ? null : widget.memberInfos[index]["avatar"];
  }

  @override
  void initState() {
    msgIndex = widget.messageData.indexWhere((element) {
      if (element["messageID"] == widget.msgID) {
        return true;
      }
      return false;
    });

    senderID = widget.messageData[msgIndex]["senderID"];
    setState(() {
      setSenderNameAndAvatar();
      replyMsgMap();
    });

    super.initState();
  }

  void replyMsgMap() {
    switch (widget.messageData[msgIndex]["type"]) {
      case "string":
        content = widget.messageData[msgIndex]["content"];
        break;
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
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    setSenderNameAndAvatar();
    return Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppStyle.white,
          border: Border(
            top: BorderSide(color: AppStyle.gray[100]!),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("正在回覆", style: AppStyle.body(color: AppStyle.teal)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            senderName,
                            style: AppStyle.header(level: 4),
                          ),
                          SizedBox(
                            width: screenWidth - 124,
                            child: Text(
                              content,
                              style: AppStyle.info(color: AppStyle.gray[500]!),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
                onTap: widget.cancelReply,
                child: Image.asset("assets/icons/x_gray.png")),
          ],
        ));
  }
}
