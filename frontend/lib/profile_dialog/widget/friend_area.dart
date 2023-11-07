part of 'profile_dialog_widget.dart';

class FriendArea extends StatefulWidget {
  const FriendArea({
    super.key,
  });

  @override
  State<FriendArea> createState() => _FriendAreaState();
}

class _FriendAreaState extends State<FriendArea> {
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
                onTap: () {
                  print("修改暱稱${state.data['memberID']}");
                  //TODO: show dialog
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
                onTap: () {
                  print("開啟聊天");
                  //TODO: 導入聊天室
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
                onTap: () {
                  print("刪除好友");
                  //TODO: 接API
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
