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

class _ChatroomPageState extends State<ChatroomPage> {
  final channel = IOWebSocketChannel.connect('wss://$host/cable');
  List<bool> chatRoomRowStates = [];
  List<Map<String, dynamic>> chatRooms = [];
  final ScrollController _scrollController = ScrollController();
  bool isEdit = false;
  bool isSort = false;
  bool isSearch = false;
  String? showChatroomType = "all";

  @override
  void initState() {
    super.initState();
    _fetchChatRooms();
  }

  Future<void> _fetchChatRooms() async {
    showLoading(context);
    try {
      final List<Map<String, dynamic>> fetchedChatRooms =
          await ChatRoomListAPI.fetchChatRooms();
      setState(() {
        chatRooms = fetchedChatRooms;
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
                setState(() {
                  showChatroomType = value;
                  print(showChatroomType);
                });
              },
              type: showChatroomType,
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.blue[100],
          ),
        ),
      ),
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
