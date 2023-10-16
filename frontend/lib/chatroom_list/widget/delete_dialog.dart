part of 'chatroom_list_widget.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

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
            "確定要刪除聊天室嗎？",
            style: AppStyle.header(),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "訊息刪除後，將無法恢復，\n請慎重考慮後再進行刪除，以免遺失重要資料",
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
                        child: Image.asset("assets/icons/delete.png"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("刪除")
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
                        child: Image.asset("assets/icons/Return_back.png"),
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

Future<bool> showDelete(BuildContext context) async {
  final temp = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const DeleteDialog(),
  );
  return temp;
}
