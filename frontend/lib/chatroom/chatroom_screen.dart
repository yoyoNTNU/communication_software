import 'package:flutter/material.dart';
import 'package:proj/main.dart';
import 'package:proj/style.dart';
import 'package:proj/chatroom/chatroom_api.dart';
import 'package:proj/chatroom/widget/chatroom_widget.dart';
import 'package:web_socket_channel/io.dart';
import 'package:proj/widget.dart';
import 'package:proj/data.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({
    super.key,
  });

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage>
    with TickerProviderStateMixin {
  final channel = IOWebSocketChannel.connect("wss://$host/cable");
  late int? chatroomID;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _messageController = TextEditingController();
  bool isExpanded = false;
  double _height = 1.0;

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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    chatroomID = ModalRoute.of(context)?.settings.arguments as int?;
    print(chatroomID);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            chatroomType: "group",
            groupPeopleCount: 10,
            isMuted: true,
            isPinned: true,
            name: "聊天室$chatroomID內部",
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
              child: Image.asset("assets/icons/Menu.png"),
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
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          //電腦版只能透過觸控板用兩指滑動 滑鼠沒辦法達到這個功能
                          children: [
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/avatar.png",
                              width: 32,
                              height: 32,
                            ),
                          ]),
                    ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppStyle.blue[100],
                  ),
                ],
              )),
        ),
        bottomNavigationBar: Container(
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
                onChanged: (value) {},
              )),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  print("Send");
                },
                child: Image.asset("assets/icons/Send.png"),
              ),
            ],
          ),
        ),
        body: Container());
  }
}
