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
            onTap: () {
              setState(() {
                isEdit = !isEdit;
                isSort = false;
                isSearch = false;
                setBottomHeightAnimated(isEdit ? 45 : 1);
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
              onChanged: (value) async {
                if (showChatroomType != value) {
                  setState(() {
                    isEdit = false;
                    isSearch = false;
                    isSort = false;
                    setBottomHeightAnimated(1);
                    sortBy = "time";
                    showChatroomType = value;
                    copyChatRooms = [];
                  });
                  await Future.delayed(const Duration(milliseconds: 100));
                  setState(() {
                    if (value == "all") {
                      copyChatRooms = chatRooms;
                    } else {
                      copyChatRooms = chatRooms
                          .where((element) => element["type"] == value)
                          .toList();
                    }
                  });
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
                  onTap: () async {
                    if (sortBy != "time") {
                      var temp = copyChatRooms;
                      setState(() {
                        isSort = false;
                        setBottomHeightAnimated(1);
                        sortBy = "time";
                        copyChatRooms = [];
                      });
                      await Future.delayed(const Duration(milliseconds: 100));
                      setState(() {
                        copyChatRooms = temp;
                        copyChatRooms.sort((a, b) =>
                            b['messageTime'].compareTo(a['messageTime']));
                      });
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
                  onTap: () async {
                    if (sortBy != "unread") {
                      var temp = copyChatRooms;
                      setState(() {
                        isSort = false;
                        setBottomHeightAnimated(1);
                        sortBy = "unread";
                        copyChatRooms = [];
                      });
                      await Future.delayed(const Duration(milliseconds: 100));
                      setState(() {
                        copyChatRooms = temp
                            .where((element) => element["isRead"] == false)
                            .toList();
                        copyChatRooms.addAll(temp
                            .where((element) => element["isRead"] == true)
                            .toList());
                      });
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
              if (isEdit)
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
            index: index - 1,
          );
        },
      ),
    );
  }
}
