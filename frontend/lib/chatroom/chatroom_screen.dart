import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/main.dart';
import 'package:proj/chatroom/chatroom_api.dart';
import 'package:proj/chatroom/widget/chatroom_widget.dart';
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
  Map<String, dynamic> chatroomData = {};
  //final channel = IOWebSocketChannel.connect("ws://localhost:3000/cable");
  List<Map<String, dynamic>> messageData = [];
  List<Map<String, dynamic>> announcementData = [];
  List<dynamic> memberNumber = [];
  List<Map<String, dynamic>> memberData = [];
  int memberCount = 0;
  bool isExpanded = false;
  double _height = 1.0;
  int step = 0;
  bool isOnTap = false;
  int? tileIsSelectedIndex;
  int currentMemberID = 0;
  bool msgFinish = false;

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
          var tempData = messageData
              .where((element) =>
                  element["messageID"] == null &&
                  element["content"] == temp["message"]["message"]["content"])
              .first;
          int tempDataIndex = messageData.indexOf(tempData);
          messageData[tempDataIndex] = temp["message"]["message"];
        });
      }
    });
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
      final List<Map<String, dynamic>> announcements =
          messages.where((element) => element["isPinned"] == true).toList();
      if (!mounted) return;
      setState(() {
        messageData = messages;
        announcementData = announcements;
        msgFinish = true;
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

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isKeyboardOpen = false;
    if (mediaQuery.viewInsets.bottom > 0) {
      isKeyboardOpen = true;
    } else {
      isKeyboardOpen = false;
    }
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
          isExpanded: isExpanded,
          onTapMemberCount: () {
            setBottomHeightAnimated(isExpanded ? 1 : 41);
            isExpanded = !isExpanded;
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
            child: Column(
              children: [
                if (isExpanded)
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 3, 24, 4),
                    height: _height - 1,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppStyle.teal),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            //電腦版只能透過觸控板用兩指滑動 滑鼠沒辦法達到這個功能
                            itemCount: memberCount,
                            itemBuilder: (BuildContext context, int index) {
                              var member = memberData[index];
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showProfileDialog(context,
                                          id: member["id"]);
                                    },
                                    child: ClipOval(
                                      clipBehavior: Clip.hardEdge,
                                      child: member["avatar"] == null
                                          ? Image.asset(
                                              "assets/images/avatar.png",
                                              width: 32,
                                              height: 32,
                                            )
                                          : Image.network(
                                              member["avatar"],
                                              width: 32,
                                              height: 32,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 24,
                          child: _height == 41
                              ? IconButton(
                                  splashRadius: 12,
                                  padding: EdgeInsets.zero,
                                  splashColor: AppStyle.white,
                                  focusColor: AppStyle.white,
                                  hoverColor: AppStyle.white,
                                  highlightColor: AppStyle.white,
                                  alignment: Alignment.centerRight,
                                  iconSize: 24,
                                  onPressed: () {
                                    print("進入成員列表");
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 24,
                                  ),
                                )
                              : null,
                        )
                      ],
                    ),
                  ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppStyle.blue[100],
                ),
              ],
            )),
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
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent + 100);
                          setState(() {
                            step++;
                          });
                        }
                      });
                      return MsgTile(
                        index: messageData[index]["messageID"],
                        chatroomType: "group",
                        senderIsMe:
                            messageData[index]["senderID"] == currentMemberID,
                        senderID: messageData[index]["senderID"],
                        messageType: messageData[index]["type"],
                        isReply: messageData[index]["isReply"],
                        replyMsgID: messageData[index]["replyToID"],
                        content: messageData[index]["content"],
                        msgTime: messageData[index]["msgTime"],
                        setAllDisSelected: isOnTap,
                        tileIsSelectedIndex: tileIsSelectedIndex,
                        memberInfos: memberData,
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
                      );
                    },
                  ),
                  if (msgFinish &&
                      ((((Platform.isAndroid || Platform.isIOS) &&
                                  !isKeyboardOpen) ||
                              (!Platform.isAndroid && !Platform.isIOS)) &&
                          _scrollController.position.pixels !=
                              _scrollController.position.maxScrollExtent))
                    Positioned(
                      bottom: 12,
                      left: MediaQuery.of(context).size.width * 0.5 - 55,
                      child: SizedBox(
                        height: 28,
                        width: 110,
                        child: FloatingActionButton(
                          onPressed: () async {
                            await _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
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
          Container(
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
                    print("DashBoard");
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
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
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
                                "isReply": false, //依實際情況
                                "reply_to_id": null, //要記得放回覆的msgID
                              }),
                            }));
                            setState(() {
                              messageData.add({
                                "messageID": null,
                                "senderID": currentMemberID,
                                "type": "string",
                                "content": _messageController.text,
                                "msgTime": dateTimeToString(DateTime.now()),
                                "isReply": false, //依實際情況
                                "replyToID": null, //要記得放回覆的msgID
                                "isPinned": false,
                              });
                              _messageController.text = "";
                            });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
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
                              "isReply": false, //依實際情況
                              "reply_to_id": null, //要記得放回覆的msgID
                            }),
                          }));
                          setState(() {
                            messageData.add({
                              "messageID": null,
                              "senderID": currentMemberID,
                              "type": "string",
                              "content": _messageController.text,
                              "msgTime": dateTimeToString(DateTime.now()),
                              "isReply": false, //依實際情況
                              "replyToID": null, //要記得放回覆的msgID
                              "isPinned": false,
                            });
                            _messageController.text = "";
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
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
