part of 'profile_dialog_widget.dart';

class DeleteDialog extends StatelessWidget {
  final bool isGroup;
  const DeleteDialog({super.key, this.isGroup = false});

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
            isGroup ? "確定要退出群組嗎？" : "確定要刪除好友嗎？",
            style: AppStyle.header(),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            isGroup
                ? "退出群組後，將無法恢復，\n退出後若要再次加入該群組，需要重新獲得群組邀請，\n請謹慎操作。"
                : "好友刪除後，將無法恢復，\n刪除後若要聯繫該好友，需要重新發送好友邀請，\n請謹慎操作。",
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
                        child: Image.asset(isGroup
                            ? "assets/icons/leave.png"
                            : "assets/icons/delete.png"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(isGroup ? "退出" : "刪除"),
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

Future<bool> showDelete(BuildContext context, {bool isGroup = false}) async {
  final temp = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => DeleteDialog(isGroup: isGroup),
  );
  return temp;
}
