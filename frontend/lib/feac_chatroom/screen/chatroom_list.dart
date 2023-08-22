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
        title: Text(widget.name),
        subtitle: Text(widget.messageContent),
        trailing: Text(formatMessageTime(widget.messageTime)),
      ),
    );
  }
}

class ChatroomPage extends StatefulWidget {
  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
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

  double initialPositionX = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          final room = chatRooms[index];
          double leftRowWidth = 0;
          double rightRowWidth = 0;
          double middleWidth = screenWidth;
          if (room["photo"] == null) {
            room["photo"] = 'assets/images/Avatar.jpg'; //這裡可以改預設照片
          } else {
            //room["photo"] = baseUrl + room["photo"];
            room["photo"] = 'assets/images/Avatar.jpg';
          }
          return GestureDetector(
              onHorizontalDragStart: (details) {
                initialPositionX = details.globalPosition.dx;
              },
              onHorizontalDragUpdate: (details) {
                double currentPositionX = details.globalPosition.dx;
                double deltaX = currentPositionX - initialPositionX;

                setState(() {
                  if (deltaX < -0.3 * screenWidth) {
                    // 左滑
                    leftRowWidth = 0.4 * screenWidth;
                    middleWidth = 0.6 * screenWidth;
                    rightRowWidth = 0;
                    print(deltaX);
                    print("left");
                  } else if (deltaX > 0.3 * screenWidth) {
                    // 右滑
                    if (room["isRead"]) {
                      leftRowWidth = 0;
                      middleWidth = 0.6 * screenWidth;
                      rightRowWidth = 0.4 * screenWidth;
                    } else {
                      leftRowWidth = 0;
                      middleWidth = 0.4 * screenWidth;
                      rightRowWidth = 0.6 * screenWidth;
                    }

                    print(initialPositionX);
                    print(currentPositionX);
                    print("right");
                  } else {
                    // 未滑动足够距离
                    leftRowWidth = deltaX < 0 ? -deltaX : 0;
                    rightRowWidth = deltaX > 0 ? -deltaX : 0;
                    middleWidth = screenWidth - leftRowWidth - rightRowWidth;
                    print(deltaX);
                    print("none");
                  }
                  print("$leftRowWidth and $middleWidth and $rightRowWidth");
                });
              },
              onHorizontalDragEnd: (_) {
                initialPositionX = 0; // 重置初始位置
              },
              child: Row(children: [
                AnimatedContainer(
                    width: 0.5 * leftRowWidth,
                    height: 0.1 * screenHeight,
                    color: Colors.blue,
                    child: Text("name"),
                    duration: const Duration(milliseconds: 500)),
                AnimatedContainer(
                    width: 0.5 * leftRowWidth,
                    height: 0.1 * screenHeight,
                    color: Colors.red,
                    child: Text("name"),
                    duration: const Duration(milliseconds: 500)),
                AnimatedContainer(
                  width: middleWidth,
                  height: 0.1 * screenHeight,
                  duration: const Duration(milliseconds: 500),
                  child: ChatRoomCard(
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
                ),
                AnimatedContainer(
                    width: 1 / 3 * rightRowWidth,
                    height: 0.1 * screenHeight,
                    color: Colors.yellow,
                    child: Text("name"),
                    duration: const Duration(milliseconds: 500)),
                AnimatedContainer(
                    width: 1 / 3 * rightRowWidth,
                    height: 0.1 * screenHeight,
                    color: Colors.green,
                    child: Text("name"),
                    duration: const Duration(milliseconds: 500)),
                AnimatedContainer(
                    width: 1 / 3 * rightRowWidth,
                    height: 0.1 * screenHeight,
                    color: Colors.blue,
                    child: Text("name"),
                    duration: const Duration(milliseconds: 500)),
              ]));
        },
      ),
    );
  }
}
