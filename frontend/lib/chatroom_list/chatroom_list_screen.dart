import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/chatroom_list/chatroom_list_api.dart';
import 'package:proj/chatroom_list/widget/chatroom_list_widget.dart';
import 'package:proj/widget.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:proj/main.dart';
import 'dart:convert';
import 'package:proj/data.dart';
import 'package:web_socket_channel/io.dart';

class ChatroomListPage extends StatefulWidget {
  const ChatroomListPage({super.key});

  @override
  State<ChatroomListPage> createState() => _ChatroomListPageState();
}

class _ChatroomListPageState extends State<ChatroomListPage>
    with TickerProviderStateMixin {
  //TODO:實時連接並更新列表
  List<Map<String, dynamic>> chatRooms = [];
  List<Map<String, dynamic>> copyChatRooms = [];
  List<int> selectedIndexList = [];
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  late SwipeActionController _swipeActionController;
  List<dynamic> channels = [];
  bool isEdit = false;
  bool isSort = false;
  bool isSearch = false;
  String? showChatroomType = "all";
  String sortBy = "time";
  double _height = 1.0;
  int selectedCount = 0;
  int? homepageIndex = 0;
  int tapTipsCount = 0; //TODO: 開發用 記得移除

  void setBottomHeightAnimated(double end) {
    _animation = Tween(begin: _height, end: end).animate(_animationController)
      ..addListener(() {
        setState(() {
          _height = _animation.value;
        });
      });
    _animationController.reset();
    _animationController.forward();
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
          .sort((a, b) => b["messageTime"].compareTo(a["messageTime"]));
      var temp2 =
          temp.where((element) => element["cmIsPinned"] == false).toList();
      temp2.sort((a, b) => b["messageTime"].compareTo(a["messageTime"]));
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
          .sort((a, b) => b["messageTime"].compareTo(a["messageTime"]));
      var temp2 = temp
          .where((element) =>
              (element["cmIsPinned"] == true && element["isRead"] == true))
          .toList();
      temp2.sort((a, b) => b["messageTime"].compareTo(a["messageTime"]));
      copyChatRooms.addAll(temp2);
      temp2 = temp
          .where((element) =>
              (element["cmIsPinned"] == false && element["isRead"] == false))
          .toList();
      temp2.sort((a, b) => b["messageTime"].compareTo(a["messageTime"]));
      copyChatRooms.addAll(temp2);
      temp2 = temp
          .where((element) =>
              (element["cmIsPinned"] == false && element["isRead"] == true))
          .toList();
      temp2.sort((a, b) => b["messageTime"].compareTo(a["messageTime"]));
      copyChatRooms.addAll(temp2);
    });
  }

  bool checkSelectedIsMuted() {
    if (selectedIndexList.isNotEmpty) {
      for (int index in selectedIndexList) {
        var temp = copyChatRooms
            .firstWhere((element) => element["chatroomID"] == index);
        if (!temp["cmIsMuted"]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool checkSelectedIsPinned() {
    if (selectedIndexList.isNotEmpty) {
      for (int index in selectedIndexList) {
        var temp = copyChatRooms
            .firstWhere((element) => element["chatroomID"] == index);
        if (!temp["cmIsPinned"]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  Future<void> _setChatRoom(int chatroomID, bool isPinned, bool isMuted,
      bool isDisabled, DateTime? deleteAt) async {
    try {
      await ChatRoomRowAPI.updateSetting(
          chatroomID, isPinned, isMuted, isDisabled, deleteAt);
    } catch (e) {
      print('API request error: $e');
    }
  }

  void onChanged({
    int? chatroomID,
    bool isPinned = false,
    bool isMuted = false,
    bool isDisabled = false,
    bool needReSort = false,
  }) {
    var room =
        chatRooms.firstWhere((element) => element["chatroomID"] == chatroomID);
    setState(() {
      room["cmIsPinned"] = isPinned;
      room["cmIsMuted"] = isMuted;
      if (isDisabled) {
        var temp = chatRooms
            .firstWhere((element) => element["chatroomID"] == chatroomID);
        chatRooms.remove(temp);
        if (showChatroomType == "all") {
          copyChatRooms = chatRooms;
        } else {
          copyChatRooms = chatRooms
              .where((element) => element["type"] == showChatroomType)
              .toList();
        }
      }
    });
    if (needReSort) {
      if (sortBy == "time") {
        sortByTime();
      } else {
        sortByUnread();
      }
      setBottomHeightAnimated(45);
    }
  }

  void _setSelectedChatRoom(String types, {bool setPinOrMute = false}) {
    for (int chatroomID in selectedIndexList) {
      var room = chatRooms
          .firstWhere((element) => element["chatroomID"] == chatroomID);
      switch (types) {
        case "Pin":
          onChanged(
            chatroomID: chatroomID,
            isPinned: setPinOrMute,
            isMuted: room["cmIsMuted"],
            needReSort: true,
          );
          _setChatRoom(
              chatroomID, setPinOrMute, room["cmIsMuted"], false, null);
          break;
        case "Mute":
          onChanged(
            chatroomID: chatroomID,
            isPinned: room["cmIsPinned"],
            isMuted: setPinOrMute,
          );
          _setChatRoom(
              chatroomID, room["cmIsPinned"], setPinOrMute, false, null);
          break;
        case "Disable":
          _swipeActionController.deselectAll();
          onChanged(
            chatroomID: chatroomID,
            isPinned: room["cmIsPinned"],
            isMuted: room["cmIsMuted"],
            isDisabled: true,
            needReSort: true,
          );
          _setChatRoom(
              chatroomID, room["cmIsPinned"], room["cmIsMuted"], true, null);
        case "Delete":
          _swipeActionController.deselectAll();
          onChanged(
            chatroomID: chatroomID,
            isPinned: room["cmIsPinned"],
            isMuted: room["cmIsMuted"],
            isDisabled: true,
            needReSort: true,
          );
          _setChatRoom(chatroomID, room["cmIsPinned"], room["cmIsMuted"], true,
              DateTime.now());
      }
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _swipeActionController = SwipeActionController(
        selectedIndexPathsChangeCallback:
            (changedIndexPaths, selected, currentCount) {
      setState(() {
        selectedCount = currentCount;
        selectedIndexList = _swipeActionController.getSelectedIndexPaths();
      });
    });
    super.initState();
    _fetchChatRooms();

    for (int i = 0; i < 2; i++) {
      //var channel = IOWebSocketChannel.connect("wss://$host/cable");
      var channel = IOWebSocketChannel.connect("ws://localhost:3000/cable");
      channel.sink.add(jsonEncode({
        'command': 'subscribe',
        'identifier': jsonEncode({
          'channel': 'ChatChannel',
          'chatroom_id': 46 + i, // 你想要订阅的聊天室ID
        }),
      }));
      channels.add(channel);
      channel.stream.listen((message) {
        var temp = jsonDecode(message);
        if (!temp.containsKey('type')) {
          print("外面收到囉：${temp["message"]["message"]["content"]}");
        }
      });
      print("訂閱");
    }

    print(channels[0]);
    print(channels[1]);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchChatRooms() async {
    homepageIndex = await DatabaseHelper.instance.getHomepageIndex();
    if (!context.mounted) return;
    showLoading(context);
    try {
      final List<Map<String, dynamic>> fetchedChatRooms =
          await ChatRoomListAPI.fetchChatRooms();
      setState(() {
        chatRooms = fetchedChatRooms;
        copyChatRooms = chatRooms;
      });
    } catch (e) {
      print("API request error: $e");
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return homepageIndex == 1
        ? Scaffold(
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
                      await ChatRoomRowAPI.updateSetting(
                          40, true, true, false, null);
                      await ChatRoomRowAPI.unReadAllMessage(40);
                      await ChatRoomRowAPI.updateSetting(
                          41, true, true, false, null);
                      await ChatRoomRowAPI.unReadAllMessage(41);
                      await ChatRoomRowAPI.updateSetting(
                          46, true, true, false, null);
                      await ChatRoomRowAPI.unReadAllMessage(46);
                      await ChatRoomRowAPI.updateSetting(
                          47, true, true, false, null);
                      await ChatRoomRowAPI.unReadAllMessage(47);
                      await ChatRoomRowAPI.updateSetting(
                          48, true, true, false, null);
                      await ChatRoomRowAPI.unReadAllMessage(48);
                      await ChatRoomRowAPI.updateSetting(
                          49, true, true, false, null);
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
                      if (isEdit) {
                        _swipeActionController.stopEditingMode();
                      } else {
                        _swipeActionController.startEditingMode();
                      }
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
                      _swipeActionController.stopEditingMode();
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
                      _swipeActionController.stopEditingMode();
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
                      "聊天室",
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
                          if (_swipeActionController.isEditing.value) {
                            _swipeActionController.deselectAll();
                            _swipeActionController.stopEditingMode();
                          }
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
                                "已選取 $selectedCount 個",
                                style: AppStyle.caption(
                                    color: AppStyle.gray[700]!),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                List<int> indexPaths = [];
                                for (var member in copyChatRooms) {
                                  indexPaths.add(member["chatroomID"]);
                                }
                                _swipeActionController.selectCellAt(
                                    indexPaths: indexPaths);
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
                                _swipeActionController.deselectAll();
                              },
                              style: AppStyle.textBtn().copyWith(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return AppStyle.gray[500]!;
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "請輸入關鍵字",
                            hintStyle:
                                AppStyle.body(color: AppStyle.gray[500]!),
                            prefixIcon: Image.asset("assets/icons/Search.png"),
                            filled: true,
                            fillColor: AppStyle.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppStyle.blue, width: 1.25),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppStyle.blue, width: 1.25),
                            ),
                          ),
                          onTap: () {
                            //TODO: 跳轉到搜尋訊息的新頁面(待補)
                            Navigator.popAndPushNamed(context, "/search");
                          },
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
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isEdit ? 80 : 0,
              decoration: BoxDecoration(
                color: AppStyle.white,
                border: Border(
                  bottom: BorderSide(
                      color: isEdit ? AppStyle.teal : Colors.transparent),
                  top: BorderSide(
                      color: isEdit ? AppStyle.sea : Colors.transparent),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: selectedCount == 0
                          ? null
                          : () {
                              _setSelectedChatRoom("Mute",
                                  setPinOrMute: !checkSelectedIsMuted());
                            },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            height: isEdit ? 24 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: checkSelectedIsMuted()
                                ? Image.asset("assets/icons/sound_teal.png")
                                : Image.asset("assets/icons/mute.png"),
                          ),
                          AnimatedContainer(
                            height: isEdit ? 16 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: checkSelectedIsMuted()
                                ? Text(
                                    "取消靜音",
                                    style: AppStyle.caption(
                                        level: 2, color: AppStyle.teal),
                                  )
                                : Text(
                                    "靜音",
                                    style: AppStyle.caption(
                                        level: 2, color: AppStyle.black),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: selectedCount == 0
                          ? null
                          : () {
                              _setSelectedChatRoom("Pin",
                                  setPinOrMute: !checkSelectedIsPinned());
                            },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            height: isEdit ? 24 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: checkSelectedIsPinned()
                                ? Image.asset(
                                    "assets/icons/cancel_pin_gray.png")
                                : Image.asset(
                                    "assets/icons/pin_dark_yellow.png"),
                          ),
                          AnimatedContainer(
                            height: isEdit ? 16 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: checkSelectedIsPinned()
                                ? Text(
                                    "取消釘選",
                                    style: AppStyle.caption(
                                        level: 2, color: AppStyle.gray[700]!),
                                  )
                                : Text(
                                    "釘選",
                                    style: AppStyle.caption(
                                        level: 2, color: AppStyle.yellow[700]!),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: selectedCount == 0
                          ? null
                          : () async {
                              bool check = await showHide(context);
                              if (check) {
                                _setSelectedChatRoom("Disable");
                              }
                            },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            height: isEdit ? 24 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: Image.asset("assets/icons/hide_gray.png"),
                          ),
                          AnimatedContainer(
                            height: isEdit ? 16 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: Text(
                              "隱藏",
                              style: AppStyle.caption(
                                  level: 2, color: AppStyle.gray[700]!),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: selectedCount == 0
                          ? null
                          : () async {
                              bool check = await showDelete(context);
                              if (check) {
                                _setSelectedChatRoom("Delete");
                              }
                            },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            height: isEdit ? 24 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: Image.asset("assets/icons/delete.png"),
                          ),
                          AnimatedContainer(
                            height: isEdit ? 16 : 0,
                            duration:
                                Duration(milliseconds: isEdit ? 400 : 200),
                            child: Text(
                              "刪除",
                              style: AppStyle.caption(
                                  level: 2, color: AppStyle.red),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: copyChatRooms.isNotEmpty
                ? ListView.separated(
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
                        controller: _swipeActionController,
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
                          type: room["type"],
                          count: room["count"],
                          sender: room["sender"],
                          enterRoom: () {},
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
                            room["cmIsPinned"] = isPinned;
                            room["cmIsMuted"] = isMuted;
                            if (isDisabled) {
                              var temp = chatRooms.firstWhere((element) =>
                                  element["chatroomID"] == chatroomID);
                              chatRooms.remove(temp);
                              if (showChatroomType == "all") {
                                copyChatRooms = chatRooms;
                              } else {
                                copyChatRooms = chatRooms
                                    .where((element) =>
                                        element["type"] == showChatroomType)
                                    .toList();
                              }
                            }
                            if (isRead) {
                              room["isRead"] = true;
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
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/fail_logo_dark.png"),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "列表空空如也，趕快開始聊天吧！",
                          style: AppStyle.info(
                              level: 2, color: AppStyle.gray[700]!),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
          )
        : Container(
            color: AppStyle.blue[50],
          );
  }
}
