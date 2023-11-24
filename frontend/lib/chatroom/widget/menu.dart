part of 'chatroom_widget.dart';

class Menu extends StatefulWidget {
  final int chatroomID;
  final VoidCallback cancelDisplayMenu;
  final IOWebSocketChannel channel;

  const Menu({
    super.key,
    required this.chatroomID,
    required this.cancelDisplayMenu,
    required this.channel,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuIcon> infoMenuIcons = [];
  List<MenuIcon> communityMenuIcons = [];

  bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  @override
  void initState() {
    if (isMobile()) {
      infoMenuIcons = [
        MenuIcon(
            iconPath: "assets/icons/camera_blue.png",
            title: "拍攝",
            onTap: () {
              print("拍攝");
            }),
        MenuIcon(
            iconPath: "assets/icons/video_recorder.png",
            title: "錄影",
            onTap: () {
              print("錄影");
            }),
      ];
      communityMenuIcons = [
        MenuIcon(
            iconPath: "assets/icons/phone_blue.png",
            title: "語音通話",
            onTap: () {
              print("語音通話");
            }),
        MenuIcon(
            iconPath: "assets/icons/cellphone_blue.png",
            title: "視訊通話",
            onTap: () {
              print("視訊通話");
            }),
      ];
    }
    List<MenuIcon> commonIcons = [
      MenuIcon(
          iconPath: "assets/icons/img_box_blue.png",
          title: "照片",
          onTap: () async {
            XFile? photo = await selectSinglePhoto();
            if (photo != null) {
              if (!mounted) return;
              showLoading(context);
              try {
                Map<String, int> data = await MessageAPI.sentXFileMessage(
                    widget.chatroomID,
                    type: "photo",
                    file: photo);
                if (data["status"] == 200) {
                  widget.channel.sink.add(jsonEncode({
                    'command': 'message',
                    'identifier': jsonEncode({
                      'channel': 'ChatChannel',
                      'chatroom_id': widget.chatroomID,
                    }),
                    'data': jsonEncode({
                      "action": "send_file_msg",
                      "messageID": data["msgID"],
                    }),
                  }));
                }
              } catch (e) {
                print('API request error: $e');
              }
              if (!mounted) return;
              Navigator.pop(context);
            }
          }),
      MenuIcon(
          iconPath: "assets/icons/stop_and_play.png",
          title: "影片",
          onTap: () {
            print("影片");
          }),
      MenuIcon(
          iconPath: "assets/icons/record.png",
          title: "錄音",
          onTap: () {
            print("錄音");
          }),
      MenuIcon(
          iconPath: "assets/icons/user_box.png",
          title: "聯絡資訊",
          onTap: () {
            print("聯絡資訊");
          }),
      MenuIcon(
          iconPath: "assets/icons/file_blue.png",
          title: "檔案",
          onTap: () {
            print("檔案");
          }),
    ];
    infoMenuIcons.addAll(commonIcons);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile() ? 369 : 250,
      decoration: const BoxDecoration(
        color: AppStyle.white,
        border: Border(
          top: BorderSide(color: AppStyle.teal),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/icons/dashboard.png"),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '選項',
                    style: AppStyle.header(level: 2, color: AppStyle.blue),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: widget.cancelDisplayMenu,
                  child: Image.asset("assets/icons/x_gray.png"),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "傳送資料",
                  style: AppStyle.header(level: 3, color: AppStyle.gray),
                ),
                const SizedBox(height: 8),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoMenuIcons[0],
                    dot(),
                    infoMenuIcons[1],
                    dot(),
                    infoMenuIcons[2],
                    dot(),
                    infoMenuIcons[3],
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoMenuIcons[4],
                    infoMenuIcons.length > 5
                        ? dot()
                        : dot(color: AppStyle.white),
                    infoMenuIcons.length > 5
                        ? infoMenuIcons[5]
                        : const SizedBox(
                            width: 64,
                            height: 66,
                          ),
                    infoMenuIcons.length > 5
                        ? dot()
                        : dot(color: AppStyle.white),
                    infoMenuIcons.length > 5
                        ? infoMenuIcons[6]
                        : const SizedBox(
                            width: 64,
                            height: 66,
                          ),
                    dot(color: AppStyle.white),
                    const SizedBox(
                      width: 64,
                      height: 66,
                    ),
                  ],
                ),
                if (isMobile()) const SizedBox(height: 16),
                if (isMobile())
                  Text(
                    "通話",
                    style: AppStyle.header(level: 3, color: AppStyle.gray),
                  ),
                if (isMobile()) const SizedBox(height: 8),
                if (isMobile())
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                if (isMobile()) const SizedBox(height: 8),
                if (isMobile())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      communityMenuIcons[0],
                      dot(),
                      communityMenuIcons[1],
                      dot(color: AppStyle.white),
                      const SizedBox(
                        width: 64,
                        height: 66,
                      ),
                      dot(color: AppStyle.white),
                      const SizedBox(
                        width: 64,
                        height: 66,
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const MenuIcon({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 66,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(iconPath),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppStyle.caption(level: 2, color: AppStyle.blue),
            ),
          ],
        ),
      ),
    );
  }
}

Widget dot({Color color = const Color(0xFFCDE1EC)}) {
  return Container(
    width: 6.0,
    height: 6.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
  );
}
