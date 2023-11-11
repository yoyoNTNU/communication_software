part of 'profile_dialog_widget.dart';

class GroupArea extends StatefulWidget {
  const GroupArea({
    super.key,
  });

  @override
  State<GroupArea> createState() => _GroupAreaState();
}

class _GroupAreaState extends State<GroupArea> {
  int chatroomID = 0;
  Future<void> _typeIDToChatroomID(String type, int id) async {
    try {
      int chatroom = await TransferAPI.typeIDToChatroomID(type, groupID: id);
      setState(() {
        chatroomID = chatroom;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  Future<void> _readMessage() async {
    try {
      await HelperAPI.readAllMessage(chatroomID);
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(4),
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await _typeIDToChatroomID("group", state.data['groupID']);
                  _readMessage();
                  if (chatroomID == 0) return;
                  if (!mounted) return;
                  Navigator.pushNamed(context, "/chatroom",
                      arguments: chatroomID);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/chat_plus_blue.png"),
                    Text(
                      '開啟聊天',
                      style: AppStyle.caption(
                        level: 2,
                        color: AppStyle.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  bool temp = await showDelete(context, isGroup: true);
                  if (temp) {
                    if (!mounted) return;
                    showLoading(context);
                    await GroupAPI.leaveGroup(state.data['groupID']);
                    await DatabaseHelper.instance.clearCache();
                    await DatabaseHelper.instance.setHomepageIndex(0);
                    if (!mounted) return;
                    Navigator.popAndPushNamed(context, "/home");
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/leave.png"),
                    Text(
                      '退出群組',
                      style: AppStyle.caption(
                        level: 2,
                        color: AppStyle.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
