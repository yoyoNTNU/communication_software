part of 'profile_dialog_widget.dart';

class FriendArea extends StatefulWidget {
  final void Function() setStateProfile;
  const FriendArea({
    super.key,
    required this.setStateProfile,
  });

  @override
  State<FriendArea> createState() => _FriendAreaState();
}

class _FriendAreaState extends State<FriendArea> {
  int chatroomID = 0;

  Future<void> _typeIDToChatroomID(String type, int id) async {
    try {
      int chatroom = await TransferAPI.typeIDToChatroomID(type, friendID: id);
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
                  final temp = await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        EditNickname(friendID: state.data['memberID']),
                  );
                  if (temp != null) {
                    state.data['name'] = temp;
                    widget.setStateProfile();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/edit_blue.png"),
                    Text(
                      '修改暱稱',
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
                  await _typeIDToChatroomID("friend", state.data['memberID']);
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
                  bool temp = await showDelete(context);
                  if (temp) {
                    if (!mounted) return;
                    showLoading(context);
                    await FriendAPI.deleteFriend(state.data['memberID']);
                    await DatabaseHelper.instance.clearCache();
                    await DatabaseHelper.instance.setHomepageIndex(0);
                    if (!mounted) return;
                    Navigator.popAndPushNamed(context, '/home');
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/cancel_red.png"),
                    Text(
                      '刪除好友',
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
