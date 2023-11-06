part of 'chatroom_list_widget.dart';

class HideDialog extends StatelessWidget {
  const HideDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
          content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "確定要隱藏聊天室嗎？",
            style: AppStyle.header(),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "聊天室隱藏後，不會被刪除，\n您可以透過朋友或群組列表進入，以重新顯示聊天室",
            style: AppStyle.body(color: AppStyle.gray[500]!),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: AppStyle.dangerBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150, 40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset("assets/icons/hide_red.png"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("隱藏")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: AppStyle.secondaryBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150, 40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset("assets/icons/return_back.png"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "取消",
                        style: AppStyle.caption(color: AppStyle.gray),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}

Future<bool> showHide(BuildContext context) async {
  final temp = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const HideDialog(),
  );
  return temp;
}
