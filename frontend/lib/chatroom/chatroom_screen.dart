import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/main.dart';
import 'package:proj/chatroom/chatroom_api.dart';
import 'package:proj/chatroom/widget/chatroom_widget.dart';
import 'dart:convert';
import 'package:proj/widget.dart';
import 'package:proj/data.dart';
import 'package:web_socket_channel/io.dart';
import 'package:intl/intl.dart';

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
  //final channel = IOWebSocketChannel.connect("ws://localhost:3000/cable");
  List<Map<String, dynamic>> messageData = [];
  bool isExpanded = false;
  double _height = 1.0;
  int step = 0;
  bool isOnTap = false;
  int? tileIsSelectedIndex;
  int currentMemberID = 0;

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
    _getAllMessage();
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

  Future<void> _getAllMessage() async {
    showLoading(context);
    try {
      final List<Map<String, dynamic>> messages =
          await MessageAPI.allMessage(widget.id);
      setState(() {
        messageData = messages;
      });
    } catch (e) {
      print("API request error: $e");
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
          chatroomType: "friend",
          groupPeopleCount: 10,
          isMuted: true,
          isPinned: true,
          name: "聊天室${widget.id}內部",
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
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              //電腦版只能透過觸控板用兩指滑動 滑鼠沒辦法達到這個功能
                              children: [
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ClipOval(
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              ]),
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
              child: ListView.builder(
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
                    setScreenOnTapAndSelectedIndex: (boolean, indexValue) {
                      setState(() {
                        isOnTap = boolean;
                        if (indexValue != -1) {
                          tileIsSelectedIndex = indexValue;
                        }
                      });
                    },
                  );
                },
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
