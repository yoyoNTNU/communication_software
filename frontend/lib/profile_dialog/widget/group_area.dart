part of 'profile_dialog_widget.dart';

class GroupArea extends StatefulWidget {
  const GroupArea({
    super.key,
  });

  @override
  State<GroupArea> createState() => _GroupAreaState();
}

class _GroupAreaState extends State<GroupArea> {
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
                  print("退出群組");
                  //TODO: 接API
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
