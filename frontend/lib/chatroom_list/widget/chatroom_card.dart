part of 'chatroom_list_widget.dart';

class ChatRoomCard extends StatefulWidget {
  final int chatroomID;
  final int messageID;
  final String messageContent;
  final String messageType;
  final String messageTime;
  final bool cmIsPinned;
  final bool cmIsMuted;
  final String name;
  final String? photo;
  final bool isRead;
  final String type;
  final int? count;
  final String sender;

  const ChatRoomCard({
    super.key,
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
    required this.type,
    this.count,
    required this.sender,
  });

  @override
  State<ChatRoomCard> createState() => _ChatRoomCardState();
}

class _ChatRoomCardState extends State<ChatRoomCard> {
  int unread = 0;
  Future<void> _getUnread() async {
    try {
      final int unreadCount =
          await ChatRoomRowAPI.getUnreadCount(widget.chatroomID);
      if (mounted) {
        setState(() {
          unread = unreadCount;
        });
      }
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUnread();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO:之後要改成popAndPush
        print("tap ${widget.chatroomID} room");
        Navigator.pushNamed(context, "/chatroom", arguments: widget.chatroomID);
      },
      child: Container(
        color: AppStyle.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              backgroundImage: widget.photo != null
                  ? NetworkImage(widget.photo!) as ImageProvider
                  : const AssetImage("assets/images/Avatar.png"),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainLine(
                      chatroomType: widget.type,
                      isMuted: widget.cmIsMuted,
                      isPinned: widget.cmIsPinned,
                      groupPeopleCount: widget.count,
                      name: widget.name),
                  const SizedBox(
                    height: 4,
                  ),
                  SecondLine(
                      sender: widget.sender,
                      messageType: widget.messageType,
                      messageContent: widget.messageContent,
                      time: widget.messageTime)
                ],
              ),
            ),
            if (!widget.isRead && unread != 0)
              const SizedBox(
                width: 16,
              ),
            (widget.isRead || unread == 0)
                ? const SizedBox()
                : Container(
                    height: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppStyle.yellow[800]!),
                        color: AppStyle.yellow),
                    child: Text(
                      unread > 999 ? "999+" : unread.toString(),
                      style: AppStyle.header(level: 3),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
