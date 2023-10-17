import 'package:flutter/material.dart';
import 'package:proj/main.dart';
import 'package:proj/style.dart';
import 'package:proj/chatroom_list/chatroom_list_api.dart';
import 'package:proj/chatroom_list/widget/chatroom_list_widget.dart';
import 'package:web_socket_channel/io.dart';
import 'package:proj/widget.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({super.key});

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage>
    with TickerProviderStateMixin {
  final channel = IOWebSocketChannel.connect('wss://$host/cable');
  //TODO:實時連接並更新列表
  List<Map<String, dynamic>> chatRooms = [];
  List<Map<String, dynamic>> copyChatRooms = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isEdit = false;
  bool isSort = false;
  bool isSearch = false;
  String? showChatroomType = "all";
  String sortBy = "time";
  double _height = 1.0;
  int tapTipsCount = 0; //TODO: 開發用 記得移除

  void setBottomHeightAnimated(double end) {
    _animation = Tween(begin: _height, end: end).animate(_controller)
      ..addListener(() {
        setState(() {
          _height = _animation.value;
        });
      });
    _controller.reset();
    _controller.forward();
  }

  void sortByTime() {
    var temp = copyChatRooms;
    setState(() {
      isSort = false;
      setBottomHeightAnimated(1);
      sortBy = "time";
      copyChatRooms = [];
    });
    //await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      copyChatRooms =
          temp.where((element) => element["cmIsPinned"] == true).toList();
      copyChatRooms
          .sort((a, b) => b['messageTime'].compareTo(a['messageTime']));
      var temp2 =
          temp.where((element) => element["cmIsPinned"] == false).toList();
      temp2.sort((a, b) => b['messageTime'].compareTo(a['messageTime']));
      copyChatRooms.addAll(temp2);
    });
  }

  void sortByUnread() {
    var temp = copyChatRooms;
    setState(() {
      isSort = false;
      setBottomHeightAnimated(1);
      sortBy = "unread";
      copyChatRooms = [];
    });
    //await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      copyChatRooms = temp
          .where((element) =>
              (element["cmIsPinned"] == true && element["isRead"] == false))
          .toList();
      copyChatRooms
          .sort((a, b) => b['messageTime'].compareTo(a['messageTime']));
      var temp2 = temp
          .where((element) =>
              (element["cmIsPinned"] == true && element["isRead"] == true))
          .toList();
      temp2.sort((a, b) => b['messageTime'].compareTo(a['messageTime']));
      copyChatRooms.addAll(temp2);
      temp2 = temp
          .where((element) =>
              (element["cmIsPinned"] == false && element["isRead"] == false))
          .toList();
      temp2.sort((a, b) => b['messageTime'].compareTo(a['messageTime']));
      copyChatRooms.addAll(temp2);
      temp2 = temp
          .where((element) =>
              (element["cmIsPinned"] == false && element["isRead"] == true))
          .toList();
      temp2.sort((a, b) => b['messageTime'].compareTo(a['messageTime']));
      copyChatRooms.addAll(temp2);
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
    _fetchChatRooms();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchChatRooms() async {
    showLoading(context);
    try {
      final List<Map<String, dynamic>> fetchedChatRooms =
          await ChatRoomListAPI.fetchChatRooms();
      setState(() {
        chatRooms = fetchedChatRooms;
        copyChatRooms = chatRooms;
      });
    } catch (e) {
      print('API request error: $e');
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 48,
        backgroundColor: AppStyle.white,
        elevation: 0,
        actions: [
          GestureDetector(
            //TODO:開發用 記得移除
            onTap: () async {
              if (tapTipsCount >= 10) {
                showLoading(context);
                await ChatRoomRowAPI.updateSetting(40, true, true, false, null);
                await ChatRoomRowAPI.unReadAllMessage(40);
                await ChatRoomRowAPI.updateSetting(41, true, true, false, null);
                await ChatRoomRowAPI.unReadAllMessage(41);
                await ChatRoomRowAPI.updateSetting(46, true, true, false, null);
                await ChatRoomRowAPI.unReadAllMessage(46);
                await ChatRoomRowAPI.updateSetting(47, true, true, false, null);
                await ChatRoomRowAPI.unReadAllMessage(47);
                await ChatRoomRowAPI.updateSetting(48, true, true, false, null);
                await ChatRoomRowAPI.unReadAllMessage(48);
                await ChatRoomRowAPI.updateSetting(49, true, true, false, null);
                await ChatRoomRowAPI.unReadAllMessage(49);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, '/home');
                }
              } else {
                setState(() {
                  tapTipsCount++;
                });
              }
            },
            child: tapTipsCount >= 10
                ? Image.asset("assets/icons/key.png")
                : Container(
                    color: AppStyle.white,
                    height: 24,
                    width: 24,
                  ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isEdit = !isEdit;
                isSort = false;
                isSearch = false;
                setBottomHeightAnimated(isEdit ? 45 : 1);
                //TODO:更改成編輯模式
              });
            },
            child: isEdit
                ? Image.asset("assets/icons/tap_check.png")
                : Image.asset("assets/icons/untap_check.png"),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isEdit = false;
                isSort = !isSort;
                isSearch = false;
                setBottomHeightAnimated(isSort ? 89 : 1);
              });
            },
            child: isSort
                ? Image.asset("assets/icons/tap_sort.png")
                : Image.asset("assets/icons/untap_sort.png"),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isEdit = false;
                isSort = false;
                isSearch = !isSearch;
                setBottomHeightAnimated(isSearch ? 53 : 1);
              });
            },
            child: isSearch
                ? Image.asset("assets/icons/tap_search.png")
                : Image.asset("assets/icons/untap_search.png"),
          ),
        ],
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Text(
                '聊天室',
                style: AppStyle.header(),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            TypeDropdownButton(
              onChanged: (value) {
                if (showChatroomType != value) {
                  setState(() {
                    isEdit = false;
                    isSearch = false;
                    isSort = false;
                    setBottomHeightAnimated(1);
                    showChatroomType = value;
                  });
                  setState(() {
                    if (value == "all") {
                      copyChatRooms = chatRooms;
                    } else {
                      copyChatRooms = chatRooms
                          .where((element) => element["type"] == value)
                          .toList();
                    }
                  });
                  if (sortBy == "time") {
                    sortByTime();
                  } else {
                    sortByUnread();
                  }
                }
              },
              type: showChatroomType,
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_height),
          child: Column(
            children: [
              if (isSort)
                GestureDetector(
                  onTap: () {
                    if (sortBy != "time") {
                      sortByTime();
                    }
                  },
                  child: Container(
                    height: (_height - 1) / 2,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 11, bottom: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sortBy == "time"
                          ? AppStyle.gray[100]!
                          : AppStyle.white,
                      border: const Border(
                        top: BorderSide(color: AppStyle.teal),
                      ),
                    ),
                    child: Text(
                      "依時間排序",
                      style: AppStyle.caption(color: AppStyle.gray[700]!),
                    ),
                  ),
                ),
              if (isSort)
                GestureDetector(
                  onTap: () {
                    if (sortBy != "unread") {
                      sortByUnread();
                    }
                  },
                  child: Container(
                    height: (_height - 1) / 2,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 11, bottom: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sortBy == "unread"
                          ? AppStyle.gray[100]!
                          : AppStyle.white,
                      border: const Border(
                        top: BorderSide(color: AppStyle.sea),
                      ),
                    ),
                    child: Text(
                      "依未讀訊息排序",
                      style: AppStyle.caption(color: AppStyle.gray[700]!),
                    ),
                  ),
                ),
              if (isEdit) //TODO:編輯模式 待改
                Container(
                  height: _height - 1,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 7, 24, 8),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppStyle.teal),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "已選取 0 個",
                          style: AppStyle.caption(color: AppStyle.gray[700]!),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          print("全選");
                        },
                        style: AppStyle.textBtn().copyWith(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                          ),
                        ),
                        child: const Text("全選"),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      TextButton(
                        onPressed: () {
                          print("清除");
                        },
                        style: AppStyle.textBtn().copyWith(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return AppStyle.gray[500]!;
                              }
                              return Colors.transparent;
                            },
                          ),
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return AppStyle.white;
                              }
                              return AppStyle.gray[500]!;
                            },
                          ),
                        ),
                        child: const Text("清除"),
                      ),
                    ],
                  ),
                ),
              if (isSearch)
                Container(
                  height: _height - 1,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 7, 24, 8),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppStyle.teal),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _searchController,
                          onTapX: () {
                            setState(() {});
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: () {
                          print("搜尋");
                          //TODO:取消button 透過點擊text file跳轉到新頁面 並在該頁面執行搜尋
                        },
                        style: AppStyle.textBtn().copyWith(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                          ),
                        ),
                        child: const Text("搜尋"),
                      ),
                    ],
                  ),
                ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppStyle.blue[100],
              ),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        controller: _scrollController,
        separatorBuilder: (context, index) {
          if (index == 0 || index == copyChatRooms.length + 1) {
            return const SizedBox(height: 8);
          }
          return const SizedBox(height: 12);
        },
        itemCount: copyChatRooms.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index == copyChatRooms.length + 1) {
            return const SizedBox(height: 8);
          }
          final room = copyChatRooms[index - 1];
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
              photo: room["photo"],
              isRead: room["isRead"]!,
              type: room['type'],
              count: room['count'],
              sender: room['sender'],
            ),
            onChanged: ({
              int? chatroomID,
              bool isPinned = false,
              bool isMuted = false,
              bool isDisabled = false,
              bool needReSort = false,
              bool isRead = false,
            }) {
              setState(() {
                room['cmIsPinned'] = isPinned;
                room['cmIsMuted'] = isMuted;
                if (isDisabled) {
                  var temp = chatRooms.firstWhere(
                      (element) => element["chatroomID"] == chatroomID);
                  chatRooms.remove(temp);
                  if (showChatroomType == "all") {
                    copyChatRooms = chatRooms;
                  } else {
                    copyChatRooms = chatRooms
                        .where((element) => element["type"] == showChatroomType)
                        .toList();
                  }
                }
                if (isRead) {
                  room['isRead'] = true;
                }
              });
              if (needReSort) {
                if (sortBy == "time") {
                  sortByTime();
                } else {
                  sortByUnread();
                }
              }
            },
          );
        },
      ),
    );
  }
}
