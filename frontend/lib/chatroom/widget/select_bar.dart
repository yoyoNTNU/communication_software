part of 'chatroom_widget.dart';

class SelectBar extends StatefulWidget {
  final bool senderIsMe;
  final String messageType;
  final int messageID;
  final VoidCallback cancelSelected;
  final void Function(int) setAnnounce;
  final String content;

  const SelectBar({
    super.key,
    required this.senderIsMe,
    required this.messageType,
    required this.messageID,
    required this.cancelSelected,
    required this.content,
    required this.setAnnounce,
  });

  @override
  State<SelectBar> createState() => _SelectBarState();
}

class _SelectBarState extends State<SelectBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: AppStyle.blue[50]),
      child: Row(
        children: [
          if (widget.messageType == "string")
            GestureDetector(
              onTap: () async {
                widget.cancelSelected();
                try {
                  widget.setAnnounce(widget.messageID);
                  await MessageAPI.setIsPinned(widget.messageID, true);
                } catch (e) {
                  print("API request error: $e");
                }
              },
              child: Container(
                color: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Image.asset("assets/icons/announce.png"),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "設為公告",
                      style: AppStyle.caption(level: 2, color: AppStyle.blue),
                    ),
                  ],
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              print("回覆");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  left: BorderSide(color: AppStyle.blue[200]!),
                ),
              ),
              child: Column(
                children: [
                  Image.asset("assets/icons/return.png"),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "回覆訊息",
                    style: AppStyle.caption(level: 2, color: AppStyle.blue),
                  ),
                ],
              ),
            ),
          ),
          if (widget.messageType == "string")
            GestureDetector(
              onTap: () {
                copyToClipboard(context, widget.content);
                widget.cancelSelected();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    left: BorderSide(color: AppStyle.blue[200]!),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Image.asset("assets/icons/copy_blue.png"),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "複製訊息",
                      style: AppStyle.caption(level: 2, color: AppStyle.blue),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.senderIsMe)
            GestureDetector(
              onTap: () {
                print("收回");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    left: BorderSide(color: AppStyle.blue[200]!),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Image.asset("assets/icons/close_ring.png"),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "收回訊息",
                      style: AppStyle.caption(level: 2, color: AppStyle.blue),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
