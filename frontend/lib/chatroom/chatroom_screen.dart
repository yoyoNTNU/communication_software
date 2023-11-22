import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/main.dart';
import 'package:proj/chatroom/chatroom_api.dart';
import 'package:proj/chatroom/widget/chatroom_widget.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'dart:convert';
import 'package:proj/widget.dart';
import 'package:proj/data.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:io';

class ChatroomPage extends StatefulWidget {
  final int id;
  const ChatroomPage({
    super.key,
    required this.id,
  });

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final channel = IOWebSocketChannel.connect("wss://$host/cable");
  int didChangeDependenciesCount = 0;
  Map<String, dynamic> chatroomData = {};
  //final channel = IOWebSocketChannel.connect("ws://localhost:3000/cable");
  List<Map<String, dynamic>> messageData = [];
  List<Map<String, dynamic>> announcementData = [];
  List<dynamic> memberNumber = [];
  List<Map<String, dynamic>> memberData = [];
  List<Map<String, dynamic>> msgTileHeights = [];
  int memberCount = 0;
  bool isShowMemberThumbnail = false;
  double _height = 1.0;
  int step = 0;
  bool isOnTap = false;
  int? tileIsSelectedIndex;
  int? replyToID;
  int currentMemberID = 0;
  bool msgFinish = false;
  bool isAnnounceExpanded = false;
  bool isAnnounceExpandedForAnime = false;
  bool isAnnounceHide = false;
  bool isDisplayMenu = false;
  Map<int, bool> isWidgetShakes = {};

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

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scrollController.addListener(() {
      setState(() {});
    });
    _getAllMessageAndChatroomInfo();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final id = dbToken?.userID;
    if (!mounted) return;
    setState(() {
      currentMemberID = id!;
    });
    if (didChangeDependenciesCount == 0) {
      channel.sink.add(jsonEncode({
        'command': 'subscribe',
        'identifier': jsonEncode({
          'channel': 'ChatChannel',
          'chatroom_id': widget.id,
        }),
      }));
      channel.stream.listen((message) {
        //收到訊息的話就建立MR
        var temp = jsonDecode(message);
        if (!temp.containsKey('type')) {
          temp["message"]["message"]["msgTime"] =
              dateTimeStringToString(temp["message"]["message"]["msgTime"]);
          setState(() {
            var tempData = messageData.where((element) =>
                element["messageID"] == null &&
                element["content"] == temp["message"]["message"]["content"]);
            if (tempData.isNotEmpty) {
              int tempDataIndex = messageData.indexOf(tempData.first);
              messageData[tempDataIndex] = temp["message"]["message"];
              isWidgetShakes[temp["message"]["message"]["messageID"]] = false;
            } else {
              messageData.add(temp["message"]["message"]);
              isWidgetShakes[temp["message"]["message"]["messageID"]] = false;
            }
          });

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 1000,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
      didChangeDependenciesCount++;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    channel.sink.close();
    super.dispose();
  }

  Future<void> _getChatroom() async {
    try {
      final Map<String, dynamic> data =
          await ChatroomAPI.getChatroom(widget.id);
      if (!mounted) return;
      setState(() {
        chatroomData = data;
      });
      if (data["type"] == "group") {
        await _getGroupMember();
      } else {
        List<int> friendship =
            await TransferAPI.chatroomIDtoFriendID(widget.id);
        for (int i = 0; i < 2; i++) {
          await _getMemberAvatar(friendship[i]);
        }
      }
    } catch (e) {
      print("API request error: $e");
    }
  }

  Future<void> _getGroupMember() async {
    try {
      int groupID = await TransferAPI.chatroomIDtoGroupID(widget.id);
      final Map<String, dynamic> data =
          await ChatroomAPI.getGroupMember(groupID);
      if (!mounted) return;
      setState(() {
        memberNumber = data["member"];
        memberCount = data["count"];
      });
      for (int i = 0; i < memberCount; i++) {
        await _getMemberAvatar(memberNumber[i]);
      }
    } catch (e) {
      print("API request error: $e");
    }
  }

  Future<void> _getMemberAvatar(int memberID) async {
    try {
      Map<String, dynamic> data;
      if (memberID == currentMemberID) {
        data = await MemberAPI.getSelfInfo();
      } else {
        data = await MemberAPI.getMemberInfo(memberID);
      }
      if (!mounted) return;
      setState(() {
        memberData.add({
          "id": memberID,
          "name": data["name"],
          "avatar": data["avatar"],
        });
      });
    } catch (e) {
      print("API request error: $e");
    }
  }

  Future<void> _getAllMessage() async {
    try {
      final List<Map<String, dynamic>> messages =
          await MessageAPI.allMessage(widget.id);
      for (var m in messages) {
        if (m["senderID"] == currentMemberID) {
          int count = 0;
          try {
            count = await MessageAPI.getReadCount(m["messageID"]);
          } catch (e) {
            count = 1;
            print("API request error: $e");
          }
          m["readCount"] = count;
        }
      }
      final List<Map<String, dynamic>> announcements =
          messages.where((element) => element["isPinned"] == true).toList();
      if (announcements.isNotEmpty) {
        announcements.sort((a, b) => b["updatedAt"].compareTo(a["updatedAt"]));
      }
      if (!mounted) return;
      setState(() {
        messageData = messages;
        announcementData = announcements;
        msgFinish = true;
        for (var m in messageData) {
          isWidgetShakes[m["messageID"]] = false;
        }
      });
    } catch (e) {
      print("API request error: $e");
    }
  }

  Future<void> _getAllMessageAndChatroomInfo() async {
    showLoading(context);
    await _getChatroom();
    await _getAllMessage();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  bool isScrollAtBottom() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isKeyboardOpen = false;
    if (mediaQuery.viewInsets.bottom > 0) {
      isKeyboardOpen = true;
    } else {
      isKeyboardOpen = false;
    }
    List<GlobalKey> msgKeys =
        List.generate(messageData.length, (index) => GlobalKey());

    return Scaffold(
      backgroundColor: AppStyle.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 56,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Image.asset(
                "assets/icons/left.png",
              ),
            ),
          ),
        ),
        toolbarHeight: 48,
        backgroundColor: AppStyle.white,
        elevation: 0,
        title: TitleLine(
          chatroomType: chatroomData["type"] ?? "",
          groupPeopleCount: memberCount,
          friendID: chatroomData["type"] == "friend" && memberData.length == 2
              ? memberData[0]["id"] == currentMemberID
                  ? memberData[1]["id"]
                  : memberData[0]["id"]
              : null,
          isMuted: chatroomData["isMuted"] ?? false,
          isPinned: chatroomData["isPinned"] ?? false,
          name: chatroomData["chatroomName"] ?? "",
          isExpanded: isShowMemberThumbnail,
          onTapMemberCount: () {
            setBottomHeightAnimated(isShowMemberThumbnail ? 1 : 41);
            isShowMemberThumbnail = !isShowMemberThumbnail;
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print("設定");
              //TODO:push to 聊天室設定
            },
            child: Image.asset("assets/icons/menu.png"),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_height),
          child: MemberThumbnailList(
            height: _height,
            memberCount: memberCount,
            memberData: memberData,
            chatroomID: widget.id,
            isShowMemberThumbnail: isShowMemberThumbnail,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isOnTap = true;
                  tileIsSelectedIndex = null;
                });
              },
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: messageData.length,
                    itemBuilder: (BuildContext context, int index) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (step == 0) {
                          Future.delayed(Duration.zero, () async {
                            int count = 0;
                            while (!isScrollAtBottom() && count < 10) {
                              await _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                              count++;
                            }
                          });
                          for (int i = 0; i < messageData.length; i++) {
                            final BuildContext? cur = msgKeys[i].currentContext;
                            if (cur == null) continue;
                            final RenderBox renderBox =
                                cur.findRenderObject() as RenderBox;
                            final msgTileHeight = renderBox.size.height;
                            setState(() {
                              if (messageData[i]["messageID"] != null) {
                                msgTileHeights.add({
                                  "messageID": messageData[i]["messageID"],
                                  "height": msgTileHeight,
                                });
                              }
                            });
                          }
                          setState(() {
                            step++;
                          });
                        } else {
                          for (int i = 0; i < messageData.length; i++) {
                            int msgIndex = msgTileHeights.indexWhere(
                                (element) =>
                                    element["messageID"] ==
                                    messageData[i]["messageID"]);
                            final BuildContext? cur = msgKeys[i].currentContext;
                            if (cur == null) continue;
                            final RenderBox renderBox =
                                cur.findRenderObject() as RenderBox;
                            final msgTileHeight = renderBox.size.height;
                            if (msgIndex == -1) {
                              setState(() {
                                if (messageData[i]["messageID"] != null) {
                                  msgTileHeights.add({
                                    "messageID": messageData[i]["messageID"],
                                    "height": msgTileHeight,
                                  });
                                }
                              });
                            } else {
                              if (msgTileHeights[msgIndex]["height"] !=
                                  msgTileHeight) {
                                setState(() {
                                  msgTileHeights[msgIndex]["height"] =
                                      msgTileHeight;
                                });
                              }
                            }
                          }
                        }
                      });
                      return MsgTile(
                        msgKey: msgKeys[index],
                        index: messageData[index]["messageID"],
                        chatroomType: chatroomData["type"] ?? "",
                        senderIsMe:
                            messageData[index]["senderID"] == currentMemberID,
                        senderID: messageData[index]["senderID"],
                        messageType: messageData[index]["type"],
                        isReply: messageData[index]["isReply"],
                        replyMsgID: messageData[index]["replyToID"],
                        content: messageData[index]["content"],
                        msgTime: messageData[index]["msgTime"],
                        readCount: messageData[index]["readCount"],
                        setAllDisSelected: isOnTap,
                        tileIsSelectedIndex: tileIsSelectedIndex,
                        messageData: messageData,
                        memberInfos: memberData,
                        focusNode: _messageFocusNode,
                        isWidgetShake:
                            isWidgetShakes[messageData[index]["messageID"]],
                        setScreenOnTapAndSelectedIndex: (boolean, indexValue) {
                          setState(() {
                            isOnTap = boolean;
                            if (indexValue != -1) {
                              tileIsSelectedIndex = indexValue;
                            }
                          });
                        },
                        cancelSelected: () {
                          setState(() {
                            isOnTap = true;
                            tileIsSelectedIndex = null;
                          });
                        },
                        setAnnounce: (msgID) async {
                          setState(() {
                            isOnTap = true;
                            tileIsSelectedIndex = null;
                          });
                          try {
                            setState(() {
                              var msg = messageData
                                  .where((element) =>
                                      element["messageID"] == msgID)
                                  .first;
                              msg["isPinned"] = true;
                              isAnnounceHide = false;
                              if (announcementData.indexWhere((element) =>
                                      element["messageID"] == msgID) ==
                                  -1) {
                                announcementData.insert(0, msg);
                              }
                            });
                            await MessageAPI.setIsPinned(msgID, true);
                          } catch (e) {
                            print("API request error: $e");
                          }
                        },
                        deleteMessage: (msgID) async {
                          setState(() {
                            isOnTap = true;
                            tileIsSelectedIndex = null;
                          });
                          try {
                            setState(() {
                              var msg = messageData
                                  .where((element) =>
                                      element["messageID"] == msgID)
                                  .first;
                              announcementData.remove(msg);
                              messageData.remove(msg);
                              isWidgetShakes.remove(msgID);
                              if (announcementData.isEmpty) {
                                isAnnounceHide = true;
                                isAnnounceExpanded = false;
                                isAnnounceExpandedForAnime = false;
                              }
                            });
                            await MessageAPI.deleteMessage(msgID);
                          } catch (e) {
                            print("API request error: $e");
                          }
                        },
                        setReplyMsgID: (msgID) async {
                          setState(() {
                            replyToID = null;
                          });
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          setState(() {
                            replyToID = msgID;
                          });
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          setState(() {});
                        },
                        jumpToReplyMsg: (replyMsgID) async {
                          await jumpTo(context, _scrollController, (
                                  {int msgID = 0, bool isNeedShake = false}) {
                            setState(() {
                              isWidgetShakes[msgID] = isNeedShake;
                            });
                          },
                              msgTileHeights: msgTileHeights,
                              targetID: replyMsgID);
                        },
                      );
                    },
                  ),
                  if (announcementData.isNotEmpty && !isAnnounceHide)
                    Positioned(
                      top: 4,
                      left: 8,
                      right: 8,
                      child: isAnnounceExpanded
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: announcementData.length > 3
                                        ? 3
                                        : announcementData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var announce = announcementData[index];
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                isAnnounceExpanded = false;
                                                isAnnounceExpandedForAnime =
                                                    false;
                                              });
                                              await jumpTo(
                                                  context, _scrollController, (
                                                      {int msgID = 0,
                                                      bool isNeedShake =
                                                          false}) {
                                                setState(() {
                                                  isWidgetShakes[msgID] =
                                                      isNeedShake;
                                                });
                                              },
                                                  msgTileHeights:
                                                      msgTileHeights,
                                                  targetID:
                                                      announce["messageID"]);
                                            },
                                            child: AnimatedContainer(
                                              height: index == 0
                                                  ? 40
                                                  : isAnnounceExpandedForAnime
                                                      ? 40
                                                      : 0,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              child: SwipeActionCell(
                                                key: ValueKey(index),
                                                backgroundColor: AppStyle.white,
                                                trailingActions: [
                                                  SwipeAction(
                                                    widthSpace: 80,
                                                    color:
                                                        const Color(0xFFFFE7E6),
                                                    content: Center(
                                                      child: Text(
                                                        '移除公告',
                                                        style: AppStyle.caption(
                                                            color:
                                                                AppStyle.red),
                                                      ),
                                                    ),
                                                    onTap: (CompletionHandler
                                                        handler) async {
                                                      handler(false);
                                                      setState(() {
                                                        announcementData
                                                            .removeAt(index);
                                                        if (announcementData
                                                            .isEmpty) {
                                                          isAnnounceHide = true;
                                                          isAnnounceExpanded =
                                                              false;
                                                          isAnnounceExpandedForAnime =
                                                              false;
                                                        }
                                                      });
                                                      try {
                                                        await MessageAPI
                                                            .setIsPinned(
                                                                announce[
                                                                    "messageID"],
                                                                false);
                                                      } catch (e) {
                                                        print(
                                                            "API request error: $e");
                                                      }
                                                    },
                                                  ),
                                                ],
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 24,
                                                      vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/announce.png",
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          announce["content"] ??
                                                              "",
                                                          style: AppStyle.body(
                                                              color: AppStyle
                                                                  .gray[700]!),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 0,
                                            thickness: 0,
                                            color: AppStyle.gray[100],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  AnimatedContainer(
                                    height: isAnnounceExpandedForAnime ? 40 : 0,
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    color: AppStyle.white,
                                    child: Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isAnnounceHide = true;
                                                isAnnounceExpanded = false;
                                                isAnnounceExpandedForAnime =
                                                    false;
                                              });
                                            },
                                            style: AppStyle.textBtn(),
                                            child: const Text("隱藏公告")),
                                        const SizedBox(width: 8),
                                        TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                isAnnounceHide = true;
                                                isAnnounceExpanded = false;
                                                isAnnounceExpandedForAnime =
                                                    false;
                                              });
                                              try {
                                                for (var announce
                                                    in announcementData) {
                                                  await MessageAPI.setIsPinned(
                                                      announce["messageID"],
                                                      false);
                                                }
                                              } catch (e) {
                                                print("API request error: $e");
                                              }
                                              if (!mounted) return;
                                              setState(() {
                                                announcementData.clear();
                                              });
                                            },
                                            style: AppStyle.textBtn(),
                                            child: Text(
                                              "刪除所有公告",
                                              style: AppStyle.caption(
                                                  color: AppStyle.red),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              isAnnounceExpandedForAnime =
                                                  false;
                                            });
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
                                            setState(() {
                                              isAnnounceExpanded = false;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.keyboard_arrow_up_rounded,
                                            size: 24,
                                            color: AppStyle.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 40,
                              child: FloatingActionButton(
                                heroTag: "announce",
                                onPressed: () async {
                                  await jumpTo(context, _scrollController, (
                                          {int msgID = 0,
                                          bool isNeedShake = false}) {
                                    setState(() {
                                      isWidgetShakes[msgID] = isNeedShake;
                                    });
                                  },
                                      msgTileHeights: msgTileHeights,
                                      targetID: announcementData[0]
                                          ["messageID"]);
                                },
                                backgroundColor: AppStyle.white,
                                elevation: 2,
                                hoverElevation: 2,
                                hoverColor: AppStyle.white,
                                splashColor: AppStyle.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/announce.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          announcementData[0]["content"] ?? "",
                                          style: AppStyle.body(
                                              color: AppStyle.gray[700]!),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isAnnounceExpanded = true;
                                          });
                                          await Future.delayed(const Duration(
                                              milliseconds: 100));
                                          setState(() {
                                            isAnnounceExpandedForAnime = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 24,
                                          color: AppStyle.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  if (msgFinish &&
                      ((((Platform.isAndroid || Platform.isIOS) &&
                                  !isKeyboardOpen) ||
                              (!Platform.isAndroid && !Platform.isIOS)) &&
                          !isScrollAtBottom()))
                    Positioned(
                      bottom: 12,
                      left: MediaQuery.of(context).size.width * 0.5 - 55,
                      child: SizedBox(
                        height: 28,
                        width: 110,
                        child: FloatingActionButton(
                          heroTag: "newest",
                          onPressed: () async {
                            int count = 0;
                            while (!isScrollAtBottom() && count < 10) {
                              await _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                              count++;
                            }
                            setState(() {});
                          },
                          backgroundColor: AppStyle.gray[100]!,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              "回到最新訊息",
                              style: AppStyle.body(color: AppStyle.gray[700]!),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (replyToID != null)
            Replying(
              memberInfos: memberData,
              messageData: messageData,
              msgID: replyToID!,
              cancelReply: () {
                setState(() {
                  replyToID = null;
                });
              },
            ),
          isDisplayMenu
              ? Menu(
                  chatroomID: widget.id,
                  cancelDisplayMenu: () {
                    setState(() {
                      isDisplayMenu = false;
                    });
                    _scrollController.jumpTo(
                      _scrollController.position.pixels -
                          (Platform.isAndroid || Platform.isIOS ? 314 : 195),
                    );
                  })
              : Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppStyle.white,
                    border: Border(
                      top: BorderSide(color: AppStyle.teal),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            replyToID = null;
                            isDisplayMenu = !isDisplayMenu;
                          });
                          _scrollController.jumpTo(
                            _scrollController.position.pixels +
                                (Platform.isAndroid || Platform.isIOS
                                    ? 315
                                    : 196),
                          );
                        },
                        child: Image.asset("assets/icons/dashboard.png"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InputTextField(
                          controller: _messageController,
                          focusNode: _messageFocusNode,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onTap: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                            );
                            int count = 0;
                            while (!isScrollAtBottom() && count < 10) {
                              await _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                              count++;
                            }
                          },
                          onSubmitted: _messageController.text == ""
                              ? null
                              : (value) {
                                  channel.sink.add(jsonEncode({
                                    'command': 'message',
                                    'identifier': jsonEncode({
                                      'channel': 'ChatChannel',
                                      'chatroom_id': widget.id,
                                    }),
                                    'data': jsonEncode({
                                      "chatroom_id": widget.id,
                                      "member_id": currentMemberID,
                                      "type_": "string",
                                      "content": _messageController.text,
                                      "isReply": replyToID != null,
                                      "reply_to_id": replyToID,
                                    }),
                                  }));
                                  setState(() {
                                    messageData.add({
                                      "messageID": null,
                                      "senderID": currentMemberID,
                                      "type": "string",
                                      "content": _messageController.text,
                                      "msgTime":
                                          dateTimeToString(DateTime.now()),
                                      "isReply": replyToID != null,
                                      "replyToID": replyToID,
                                      "isPinned": false,
                                      "updatedAt":
                                          dateTimeToString(DateTime.now()),
                                    });

                                    _messageController.text = "";
                                    replyToID = null;
                                  });
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Future.delayed(Duration.zero, () async {
                                      int count = 0;
                                      while (
                                          !isScrollAtBottom() && count < 10) {
                                        await _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear,
                                        );
                                        count++;
                                      }
                                    });
                                  });
                                  _messageFocusNode.requestFocus();
                                },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: _messageController.text == ""
                            ? null
                            : () {
                                channel.sink.add(jsonEncode({
                                  'command': 'message',
                                  'identifier': jsonEncode({
                                    'channel': 'ChatChannel',
                                    'chatroom_id': widget.id,
                                  }),
                                  'data': jsonEncode({
                                    "chatroom_id": widget.id,
                                    "member_id": currentMemberID,
                                    "type_": "string",
                                    "content": _messageController.text,
                                    "isReply": replyToID != null,
                                    "reply_to_id": replyToID,
                                  }),
                                }));
                                setState(() {
                                  messageData.add({
                                    "messageID": null,
                                    "senderID": currentMemberID,
                                    "type": "string",
                                    "content": _messageController.text,
                                    "msgTime": dateTimeToString(DateTime.now()),
                                    "isReply": replyToID != null,
                                    "replyToID": replyToID,
                                    "isPinned": false,
                                    "updatedAt":
                                        dateTimeToString(DateTime.now()),
                                  });
                                  _messageController.text = "";
                                  replyToID = null;
                                });
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Future.delayed(Duration.zero, () async {
                                    int count = 0;
                                    while (!isScrollAtBottom() && count < 10) {
                                      await _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear,
                                      );
                                      count++;
                                    }
                                  });
                                });
                                _messageFocusNode.requestFocus();
                              },
                        child: Image.asset("assets/icons/send.png"),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
