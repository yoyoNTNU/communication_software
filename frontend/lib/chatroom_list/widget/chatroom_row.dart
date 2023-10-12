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
  double initialPositionX = 0;
  double leftRowWidth = 0;
  double rightRowWidth = 0;
  double middleWidth = 0;
  bool left = false;
  bool right = false;

  @override
  void initState() {
    super.initState();
    middleWidth = widget.screenWid;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (!widget.isPressed) {
      setState(() {
        middleWidth = screenWidth;
        leftRowWidth = 0;
        rightRowWidth = 0;
      });
    }
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppStyle.sea), // 設定上邊框的顏色
          bottom: BorderSide(color: AppStyle.sea), // 設定下邊框的顏色
        ),
      ),
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          initialPositionX = details.globalPosition.dx;
          setState(() {
            widget.setIsPressed(widget.index, true);
            for (int i = 0; i < widget.totalCount; i++) {
              if (i != widget.index) {
                widget.setIsPressed(i, false);
              }
            }
          });
        },
        onHorizontalDragUpdate: (details) {
          double currentPositionX = details.globalPosition.dx;
          double deltaX = currentPositionX - initialPositionX;

          setState(() {
            if (!left && !right) {
              //在中間
              // print(1);
              if (deltaX > 160) {
                //左往右滑(打開左側面板)
                //print(2);
                left = true;
                leftRowWidth = 160;
                middleWidth = screenWidth - leftRowWidth;
                rightRowWidth = 0;
              } else if (deltaX < -160) {
                //右往左滑(打開右側面板)
                //print(3);
                right = true;
                if (widget.room.isRead) {
                  //已讀
                  // print(4);
                  leftRowWidth = 0;
                  middleWidth = screenWidth - rightRowWidth;
                  rightRowWidth = 160;
                } else {
                  //未讀
                  // print(5);
                  leftRowWidth = 0;
                  middleWidth = screenWidth - rightRowWidth;
                  rightRowWidth = 240;
                }
              } else {
                // 未滑动足够距离
                // print(6);
                leftRowWidth = deltaX > 0 ? deltaX : 0;
                rightRowWidth = deltaX < 0 ? -deltaX : 0;
                middleWidth = screenWidth - leftRowWidth - rightRowWidth;
              }
            } else if (left) {
              //左邊開啟的狀態
              // print(7);
              if (deltaX > 0) {
                //左往右滑(極限拉扯)
                // print(8);
                left = true;
                leftRowWidth = 50 > deltaX ? 160 + deltaX : 210;
                middleWidth = screenWidth - leftRowWidth;
                rightRowWidth = 0;
              } else if (deltaX < -160) {
                //右往左滑(關閉左側面板)
                // print(9);
                left = false;
                initialPositionX = details.globalPosition.dx;
                leftRowWidth = 0;
                middleWidth = screenWidth;
                rightRowWidth = 0;
              } else {
                // 未滑动足够距离(左側面板仍開)
                // print(10);
                leftRowWidth = 160 + deltaX;
                rightRowWidth = 0;
                middleWidth = screenWidth - leftRowWidth;
              }
            } else if (right) {
              //右邊開啟的狀態
              // print(11);
              if (deltaX < 0) {
                //右往左滑(極限拉扯)
                // print(12);
                right = true;
                if (widget.room.isRead) {
                  //已讀
                  // print(13);
                  rightRowWidth = -50 < deltaX ? 160 - deltaX : 210;
                  middleWidth = screenWidth - rightRowWidth;
                  leftRowWidth = 0;
                } else {
                  //未讀
                  // print(14);
                  rightRowWidth = -50 < deltaX ? 240 - deltaX : 290;
                  middleWidth = screenWidth - rightRowWidth;
                  leftRowWidth = 0;
                }
              } else if (deltaX > 160) {
                //左往右滑(關閉右側面板)
                // print(15);
                right = false;
                initialPositionX = details.globalPosition.dx;
                leftRowWidth = 0;
                middleWidth = screenWidth;
                rightRowWidth = 0;
              } else {
                // 未滑动足够距离(右側面板仍開)
                // print(16);
                if (widget.room.isRead) {
                  //已讀
                  // print(17);
                  leftRowWidth = 0;
                  rightRowWidth = 160 - deltaX;
                  middleWidth = screenWidth - rightRowWidth;
                } else {
                  //未讀
                  // print(18);
                  leftRowWidth = 0;
                  rightRowWidth = 240 - deltaX;
                  middleWidth = screenWidth - rightRowWidth;
                }
              }
            }
          });
        },
        onHorizontalDragEnd: (_) {
          // print(
          //     "$leftRowWidth and $middleWidth and $rightRowWidth and $screenWidth");
          setState(() {
            if (left) {
              leftRowWidth = 160;
              rightRowWidth = 0;
              middleWidth = screenWidth - leftRowWidth;
            } else if (right) {
              leftRowWidth = 0;
              rightRowWidth = widget.room.isRead ? 160 : 240;
              middleWidth = screenWidth - rightRowWidth;
            } else {
              leftRowWidth = 0;
              rightRowWidth = 0;
              middleWidth = screenWidth;
            }
          });
          initialPositionX = 0; // 重置初始位置
        },
        child: Row(
          children: [
            AnimatedContainer(
              width: 0.5 * leftRowWidth,
              height: 80,
              alignment: Alignment.center,
              color: const Color(0xFFFFE7E6),
              duration: const Duration(milliseconds: 300),
              child: leftRowWidth == 0
                  ? null
                  : widget.room.cmIsMuted
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
                            Text('靜音',
                                style: AppStyle.caption(level: 2),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1)
                          ],
                        ),
            ),
            AnimatedContainer(
              width: 0.5 * leftRowWidth,
              height: 80,
              alignment: Alignment.center,
              color: const Color(0xFFFFF4D8),
              duration: const Duration(milliseconds: 300),
              child: leftRowWidth == 0
                  ? null
                  : widget.room.cmIsPinned
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/cancel_pin.png'),
                            Text('取消釘選',
                                style: AppStyle.caption(level: 2),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1)
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/pin.png'),
                            Text('釘選',
                                style: AppStyle.caption(level: 2),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1)
                          ],
                        ),
            ),
            AnimatedContainer(
              width: middleWidth,
              height: 80,
              duration: const Duration(milliseconds: 300),
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
              ),
            ),
            AnimatedContainer(
              width: widget.room.isRead ? 0 : (1 / 3) * rightRowWidth,
              height: 80,
              alignment: Alignment.center,
              color: const Color(0xFFCDE1EC),
              duration: const Duration(milliseconds: 300),
              child: rightRowWidth == 0
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/view.png'),
                        Text('已讀',
                            style: AppStyle.caption(level: 2),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)
                      ],
                    ),
            ),
            AnimatedContainer(
              width: widget.room.isRead
                  ? (1 / 2) * rightRowWidth
                  : (1 / 3) * rightRowWidth,
              height: 80,
              alignment: Alignment.center,
              color: const Color(0xFFEBEBEB),
              duration: const Duration(milliseconds: 300),
              child: rightRowWidth == 0
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/hide.png'),
                        Text('隱藏',
                            style: AppStyle.caption(level: 2),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)
                      ],
                    ),
            ),
            AnimatedContainer(
              width: widget.room.isRead
                  ? (1 / 2) * rightRowWidth
                  : (1 / 3) * rightRowWidth,
              height: 80,
              alignment: Alignment.center,
              color: const Color(0xFFFFE7E6),
              duration: const Duration(milliseconds: 300),
              child: rightRowWidth == 0
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/delete.png'),
                        Text('刪除',
                            style:
                                AppStyle.caption(level: 2, color: AppStyle.red),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
