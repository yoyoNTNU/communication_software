import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import '../api/chatroom_list_api.dart';
import 'package:intl/intl.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    if (!widget.isPressed) {
      setState(() {
        middleWidth = screenWidth;
        leftRowWidth = 0;
        rightRowWidth = 0;
      });
    }
    return GestureDetector(
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
                leftRowWidth = 0.4 * screenWidth;
                middleWidth = 0.6 * screenWidth;
                rightRowWidth = 0;
              } else if (deltaX < -0.3 * screenWidth) {
                //右往左滑(打開右側面板)
                //print(3);
                right = true;
                if (widget.room.isRead) {
                  //已讀
                  // print(4);
                  leftRowWidth = 0;
                  middleWidth = 0.6 * screenWidth;
                  rightRowWidth = 0.4 * screenWidth;
                } else {
                  //未讀
                  // print(5);
                  leftRowWidth = 0;
                  middleWidth = 0.4 * screenWidth;
                  rightRowWidth = 0.6 * screenWidth;
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
                    ? 0.4 * screenWidth + deltaX
                    : 0.5 * screenWidth;
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
                leftRowWidth = 0.4 * screenWidth + deltaX;
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
                      ? 0.4 * screenWidth - deltaX
                      : 0.5 * screenWidth;
                  middleWidth = screenWidth - rightRowWidth;
                  leftRowWidth = 0;
                } else {
                  //未讀
                  // print(14);
                  rightRowWidth = -0.1 * screenWidth < deltaX
                      ? 0.6 * screenWidth - deltaX
                      : 0.7 * screenWidth;
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
                  rightRowWidth = 0.4 * screenWidth - deltaX;
                  middleWidth = screenWidth - rightRowWidth;
                } else {
                  //未讀
                  // print(18);
                  leftRowWidth = 0;
                  rightRowWidth = 0.6 * screenWidth - deltaX;
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
              leftRowWidth = 0.4 * screenWidth;
              rightRowWidth = 0;
              middleWidth = 0.6 * screenWidth;
            } else if (right) {
              leftRowWidth = 0;
              rightRowWidth =
                  widget.room.isRead ? 0.4 * screenWidth : 0.6 * screenWidth;
              middleWidth =
                  widget.room.isRead ? 0.6 * screenWidth : 0.4 * screenWidth;
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
              height: 0.1 * screenHeight,
              color: Colors.blue,
              child: Text("name"),
              duration: const Duration(milliseconds: 300)),
          AnimatedContainer(
              width: 0.5 * leftRowWidth,
              height: 0.1 * screenHeight,
              color: Colors.red,
              child: Text("name"),
              duration: const Duration(milliseconds: 300)),
          AnimatedContainer(
            width: middleWidth,
            height: 0.1 * screenHeight,
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
              height: 0.1 * screenHeight,
              color: Colors.yellow,
              child: Text("name"),
              duration: const Duration(milliseconds: 300)),
          AnimatedContainer(
              width: widget.room.isRead
                  ? (1 / 2) * rightRowWidth
                  : (1 / 3) * rightRowWidth,
              height: 0.1 * screenHeight,
              color: Colors.green,
              child: Text("name"),
              duration: const Duration(milliseconds: 300)),
          AnimatedContainer(
              width: widget.room.isRead
                  ? (1 / 2) * rightRowWidth
                  : (1 / 3) * rightRowWidth,
              height: 0.1 * screenHeight,
              color: Colors.blue,
              child: Text("name"),
              duration: const Duration(milliseconds: 300)),
        ]));
  }
}

class ChatroomPage extends StatefulWidget {
  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  List<bool> chatRoomRowStates = [];
  List<Map<String, dynamic>> chatRooms = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchChatRooms();
  }

  Future<void> _fetchChatRooms() async {
    try {
      final List<Map<String, dynamic>> fetchedChatRooms =
          await ChatRoomList.fetchChatRooms();
      setState(() {
        chatRooms = fetchedChatRooms;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  final String baseUrl =
      'https://express-message-development.onrender.com/'; //這裡也要改成照分支

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppStyle.yellow[500],
          title: GestureDetector(
              onTap: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: const Text('Express Message'))),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            for (int i = 0; i < chatRooms.length; ++i) {
              chatRoomRowStates.add(false);
            }
            final room = chatRooms[index];
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
                index: index,
                isPressed: chatRoomRowStates[index],
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
