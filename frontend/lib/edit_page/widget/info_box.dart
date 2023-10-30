part of 'edit_page_widget.dart';

Widget infoBox(BuildContext context, String? birthday, String? name,
    String? intro, Function(String, String) update) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("個人資料"),
        const SizedBox(
          height: 12,
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppStyle.gray[100],
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine("使用者名稱", name ?? "", () async {
          final temp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditName(),
          );
          if (temp != null) {
            update("name", temp);
          }
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine("個性簽名", intro ?? "", () async {
          final temp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditIntro(),
          );
          if (temp != null) {
            update("intro", temp);
          }
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine(
            "生日",
            (birthday == null || birthday == "")
                ? "未設定"
                : birthday.replaceAll('-', ' / '), () async {
          final temp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditBD(),
          );
          if (temp != null) {
            update("birthday", temp);
          }
        }),
      ],
    ),
  );
}