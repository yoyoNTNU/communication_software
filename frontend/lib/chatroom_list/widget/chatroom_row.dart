part of 'chatroom_list_widget.dart';

class ChatRoomRow extends StatefulWidget {
  final ChatRoomCard room;
  final int index;
  final double screenWid;
  final bool isPressed;
  final void Function(int, bool) setIsPressed;
  final int totalCount;

  const ChatRoomRow({
    super.key,
    required this.screenWid,
    required this.room,
    required this.index,
    required this.isPressed,
    required this.totalCount,
    required this.setIsPressed,
  });

  @override
  State<ChatRoomRow> createState() => _ChatRoomRowState();
}

class _ChatRoomRowState extends State<ChatRoomRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppStyle.black,
        border: Border(
          top: BorderSide(color: AppStyle.sea),
          bottom: BorderSide(color: AppStyle.sea),
        ),
      ),
      child: SwipeActionCell(
        key: ValueKey(widget.index),
        leadingActions: [
          SwipeAction(
            widthSpace: 80,
            color: const Color(0xFFFFE7E6),
            content: Center(
              child: widget.room.cmIsMuted
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/sound.png'),
                        Text(
                          '取消靜音',
                          style: AppStyle.caption(level: 2),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/mute.png'),
                        Text(
                          '靜音',
                          style: AppStyle.caption(level: 2),
                        )
                      ],
                    ),
            ),
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("靜音");
              setState(() {});
            },
          ),
          SwipeAction(
            widthSpace: 80,
            color: AppStyle.yellow[100]!,
            content: Center(
              child: widget.room.cmIsPinned
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/cancel_pin.png'),
                        Text(
                          '取消釘選',
                          style: AppStyle.caption(level: 2),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/pin.png'),
                        Text(
                          '釘選',
                          style: AppStyle.caption(level: 2),
                        )
                      ],
                    ),
            ),
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("釘選");
              setState(() {});
            },
          ),
        ],
        trailingActions: [
          SwipeAction(
            widthSpace: 80,
            color: const Color(0xFFFFE7E6),
            content: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/delete.png'),
                  Text(
                    '刪除',
                    style: AppStyle.caption(level: 2, color: AppStyle.red),
                  )
                ],
              ),
            ),
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("刪除");
              setState(() {});
            },
          ),
          SwipeAction(
            widthSpace: 80,
            color: AppStyle.gray[100]!,
            content: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/hide.png'),
                  Text(
                    '隱藏',
                    style: AppStyle.caption(level: 2),
                  )
                ],
              ),
            ),
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("隱藏");
              setState(() {});
            },
          ),
          if (!widget.room.isRead)
            SwipeAction(
              widthSpace: 80,
              color: AppStyle.blue[100]!,
              content: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/view.png'),
                    Text(
                      '已讀',
                      style: AppStyle.caption(level: 2),
                    )
                  ],
                ),
              ),
              onTap: (CompletionHandler handler) async {
                handler(false);
                print("已讀");
                setState(() {});
              },
            ),
        ],
        child: ChatRoomCard(
          chatroomID: widget.room.chatroomID,
          messageID: widget.room.messageID,
          messageContent: widget.room.messageContent,
          messageType: widget.room.messageType,
          messageTime: widget.room.messageTime,
          cmIsPinned: widget.room.cmIsPinned,
          cmIsMuted: widget.room.cmIsMuted,
          name: widget.room.name,
          photo: widget.room.photo,
          isRead: widget.room.isRead,
          type: widget.room.type,
          count: widget.room.count,
          sender: widget.room.sender,
        ),
      ),
    );
  }
}
