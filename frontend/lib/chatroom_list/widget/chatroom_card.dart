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
  });

  @override
  State<ChatRoomCard> createState() => _ChatRoomCardState();
}

class _ChatRoomCardState extends State<ChatRoomCard> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
                      chatroomType: "group",
                      isMuted: true,
                      isPinned: true,
                      groupPeopleCount: 3333,
                      name: "123321"),
                  const SizedBox(
                    height: 4,
                  ),
                  SecondLine(
                      sender: "您",
                      messageType: "string",
                      messageContent: "今天晚上吃什麼",
                      time: "2023-10-10T13:39:46.122+08:00")
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppStyle.yellow[800]!),
                  color: AppStyle.yellow),
              child: Text(
                "123",
                style: AppStyle.header(level: 3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// ListTile(
//       isThreeLine: true,
//       titleAlignment: ListTileTitleAlignment.top,
//       contentPadding: EdgeInsets.zero,
//       tileColor: AppStyle.white,
//       hoverColor: AppStyle.white,
//       splashColor: AppStyle.white,
//       leading: Align(
//         alignment: Alignment.topLeft,
//         child: CircleAvatar(
//           radius: 24,
//           backgroundColor: Colors.transparent,
//           backgroundImage: widget.photo != null
//               ? NetworkImage(widget.photo!) as ImageProvider
//               : const AssetImage("assets/images/Avatar.png"),
//         ),
//       ),
//       title: Text(
//         widget.name,
//         overflow: TextOverflow.ellipsis, // 多余文本用...表示
//         maxLines: 1, style: AppStyle.header(level: 2),
//       ),
//       subtitle: Text(
//         widget.messageContent,
//         overflow: TextOverflow.ellipsis, // 多余文本用...表示
//         maxLines: 1, style: AppStyle.info(color: AppStyle.gray[600]!),
//       ),
//       trailing: Text(formatMessageTime(widget.messageTime),
//           overflow: TextOverflow.ellipsis, // 多余文本用...表示
//           maxLines: 1),
//       onTap: () {
//         //TODO 要記得考慮參數傳遞
//         // 在這個函式裡面導航到對應的聊天室頁面
//         // 你可以使用 Navigator.push 來執行導航
//         print("tap ${widget.chatroomID} room");
//       },
//     );
