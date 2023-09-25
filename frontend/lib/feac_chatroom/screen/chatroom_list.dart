import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import '../api/chatroom_list_api.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:proj/widget.dart';

//不要每次都重新叫API
class ChatRoomCard extends StatefulWidget {
  final int chatroomID;
  final int messageID;
  final String messageContent;
  final String messageType;
  final String messageTime;
  final bool cmIsPinned;
  final bool cmIsMuted;
  final String name;
  final String photo;
  final bool isRead;

  const ChatRoomCard({
    required this.chatroomID,
    required this.messageID,
    required this.messageContent,
    required this.messageType,
    required this.messageTime,
    required this.cmIsPinned,
    required this.cmIsMuted,
    required this.name,
    required this.photo,
    required this.isRead,
  });
  @override
  _ChatRoomCardState createState() => _ChatRoomCardState();
}

class _ChatRoomCardState extends State<ChatRoomCard> {
  String formatMessageTime(String messageTime) {
    final DateTime now = DateTime.now();
    final DateTime uctDateTime = DateTime.parse(messageTime);
    DateTime messageDateTime = uctDateTime.toLocal();
    if (now.year == messageDateTime.year &&
        now.month == messageDateTime.month &&
        now.day == messageDateTime.day) {
      // 同一天，顯示(上午/下午 hh:mm)
      final String period = messageDateTime.hour < 12 ? '上午' : '下午';

      final String time = DateFormat('hh:mm').format(messageDateTime);
      return '$period $time';
    } else if (now.year == messageDateTime.year &&
        now.month == messageDateTime.month &&
        now.day - messageDateTime.day == 1) {
      // 前一天，顯示"昨天"
      return '昨天';
    } else if (now.year == messageDateTime.year &&
        now.month == messageDateTime.month &&
        now.day - messageDateTime.day < 7) {
      switch (messageDateTime.weekday) {
        case 1:
          return '星期一';
        case 2:
          return '星期二';
        case 3:
          return '星期三';
        case 4:
          return '星期四';
        case 5:
          return '星期五';
        case 6:
          return '星期六';
        case 7:
          return '星期日';
      }
      return 'error';
    } else {
      // 更之前，顯示月份/日期
      return DateFormat('MM/dd').format(messageDateTime);
    }
  }

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isPressed = true;
        });
        //TODO 要記得考慮參數傳遞
        // 在這個函式裡面導航到對應的聊天室頁面
        // 你可以使用 Navigator.push 來執行導航
        print("tap ${widget.chatroomID} room");
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: ListTile(
        tileColor: isPressed ? Colors.grey : Colors.white,
        leading: CircleAvatar(
          backgroundImage: widget.photo.startsWith('http')
              ? NetworkImage(widget.photo) as ImageProvider
              : AssetImage(widget.photo),
        ),
        title: Text(widget.name,
            overflow: TextOverflow.ellipsis, // 多余文本用...表示
            maxLines: 1),
        subtitle: Text(widget.messageContent,
            overflow: TextOverflow.ellipsis, // 多余文本用...表示
            maxLines: 1),
        trailing: Text(formatMessageTime(widget.messageTime),
            overflow: TextOverflow.ellipsis, // 多余文本用...表示
            maxLines: 1),
      ),
    );
  }
}

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
  _ChatRoomRowState createState() => _ChatRoomRowState();
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
                  if (deltaX > 0.3 * screenWidth) {
                    //左往右滑(打開左側面板)
                    //print(2);
                    left = true;
                    leftRowWidth = 0.3 * screenWidth;
                    middleWidth = 0.7 * screenWidth;
                    rightRowWidth = 0;
                  } else if (deltaX < -0.3 * screenWidth) {
                    //右往左滑(打開右側面板)
                    //print(3);
                    right = true;
                    if (widget.room.isRead) {
                      //已讀
                      // print(4);
                      leftRowWidth = 0;
                      middleWidth = 0.7 * screenWidth;
                      rightRowWidth = 0.3 * screenWidth;
                    } else {
                      //未讀
                      // print(5);
                      leftRowWidth = 0;
                      middleWidth = 0.55 * screenWidth;
                      rightRowWidth = 0.45 * screenWidth;
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
                    leftRowWidth = 0.1 * screenWidth > deltaX
                        ? 0.3 * screenWidth + deltaX
                        : 0.4 * screenWidth;
                    middleWidth = screenWidth - leftRowWidth;
                    rightRowWidth = 0;
                  } else if (deltaX < -0.3 * screenWidth) {
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
                    leftRowWidth = 0.3 * screenWidth + deltaX;
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
                      rightRowWidth = -0.1 * screenWidth < deltaX
                          ? 0.3 * screenWidth - deltaX
                          : 0.4 * screenWidth;
                      middleWidth = screenWidth - rightRowWidth;
                      leftRowWidth = 0;
                    } else {
                      //未讀
                      // print(14);
                      rightRowWidth = -0.1 * screenWidth < deltaX
                          ? 0.45 * screenWidth - deltaX
                          : 0.55 * screenWidth;
                      middleWidth = screenWidth - rightRowWidth;
                      leftRowWidth = 0;
                    }
                  } else if (deltaX > 0.3 * screenWidth) {
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
                      rightRowWidth = 0.3 * screenWidth - deltaX;
                      middleWidth = screenWidth - rightRowWidth;
                    } else {
                      //未讀
                      // print(18);
                      leftRowWidth = 0;
                      rightRowWidth = 0.45 * screenWidth - deltaX;
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
                  leftRowWidth = 0.3 * screenWidth;
                  rightRowWidth = 0;
                  middleWidth = 0.7 * screenWidth;
                } else if (right) {
                  leftRowWidth = 0;
                  rightRowWidth = widget.room.isRead
                      ? 0.3 * screenWidth
                      : 0.45 * screenWidth;
                  middleWidth = widget.room.isRead
                      ? 0.7 * screenWidth
                      : 0.55 * screenWidth;
                } else {
                  leftRowWidth = 0;
                  rightRowWidth = 0;
                  middleWidth = screenWidth;
                }
              });
              initialPositionX = 0; // 重置初始位置
            },
            child: Row(children: [
              AnimatedContainer(
                  width: 0.5 * leftRowWidth,
                  height: 0.15 * screenWidth,
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
                                Text('取消靜音', style: AppStyle.caption(level: 2))
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
                            )),
              AnimatedContainer(
                  width: 0.5 * leftRowWidth,
                  height: 0.15 * screenWidth,
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
                            )),
              AnimatedContainer(
                width: middleWidth,
                height: 0.15 * screenWidth,
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
                  height: 0.15 * screenWidth,
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
                        )),
              AnimatedContainer(
                  width: widget.room.isRead
                      ? (1 / 2) * rightRowWidth
                      : (1 / 3) * rightRowWidth,
                  height: 0.15 * screenWidth,
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
                        )),
              AnimatedContainer(
                  width: widget.room.isRead
                      ? (1 / 2) * rightRowWidth
                      : (1 / 3) * rightRowWidth,
                  height: 0.15 * screenWidth,
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
                                style: AppStyle.caption(
                                    level: 2, color: AppStyle.red),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1)
                          ],
                        )),
            ])));
  }
}

class ChatroomPage extends StatefulWidget {
  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  final channel = IOWebSocketChannel.connect('ws://localhost:3000/cable');
  List<bool> chatRoomRowStates = [];
  List<Map<String, dynamic>> chatRooms = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchChatRooms();
  }

  Future<void> _fetchChatRooms() async {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingDialog(),
      );
    });
    try {
      final List<Map<String, dynamic>> fetchedChatRooms =
          await ChatRoomList.fetchChatRooms();

      setState(() {
        chatRooms = fetchedChatRooms;
      });
    } catch (e) {
      print('API request error: $e');
    }
    Navigator.of(context).pop();
  }

  final String baseUrl =
      'https://express-message-development.onrender.com/'; //這裡也要改成照分支

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.blue[50],
      appBar: AppBar(
          backgroundColor: AppStyle.white,
          title: GestureDetector(
              onTap: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Text('聊天室', style: AppStyle.header()))),
      body: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) {
            if (index == 0 || index == chatRooms.length + 1) {
              return const SizedBox(height: 8);
            }
            return const SizedBox(height: 12);
          },
          itemCount: chatRooms.length + 2,
          itemBuilder: (context, index) {
            for (int i = 0; i < chatRooms.length; ++i) {
              chatRoomRowStates.add(false);
            }
            if (index == 0 || index == chatRooms.length + 1) {
              return const SizedBox(height: 8);
            }
            final room = chatRooms[index - 1];
            if (room["photo"] == null) {
              room["photo"] = 'assets/images/Avatar.jpg'; //這裡可以改預設照片
            } else {
              //room["photo"] = baseUrl + room["photo"];
              room["photo"] = 'assets/images/Avatar.jpg';
            }
            return ChatRoomRow(
                room: ChatRoomCard(
                  chatroomID: room["chatroomID"]!,
                  messageID: room["messageID"]!,
                  messageContent: room["messageContent"]!,
                  messageType: room["messageType"]!,
                  messageTime: room["messageTime"]!,
                  cmIsPinned: room["cmIsPinned"]!,
                  cmIsMuted: room["cmIsMuted"]!,
                  name: room["name"]!,
                  photo: room["photo"]!,
                  isRead: room["isRead"]!,
                ),
                index: index - 1,
                isPressed: chatRoomRowStates[index - 1],
                setIsPressed: (int rowIndex, bool value) {
                  setState(() {
                    chatRoomRowStates[rowIndex] = value;
                  });
                },
                totalCount: chatRooms.length,
                screenWid: MediaQuery.of(context).size.width);
          }),
    );
  }
}
