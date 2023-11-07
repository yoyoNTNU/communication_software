part of 'profile_dialog_widget.dart';

class SelfArea extends StatefulWidget {
  const SelfArea({
    super.key,
  });

  @override
  State<SelfArea> createState() => _SelfAreaState();
}

class _SelfAreaState extends State<SelfArea> {
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
                  Navigator.popAndPushNamed(context, '/edit');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/edit_blue.png"),
                    Text(
                      '編輯資料',
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
                  copyToClipboard(context, state.data['userID']);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/copy_blue.png"),
                    Text(
                      '複製ID',
                      style: AppStyle.caption(
                        level: 2,
                        color: AppStyle.blue,
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
