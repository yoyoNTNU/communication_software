part of 'edit_page_widget.dart';

Widget communityBox(BuildContext context, String? email, String? phone) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("通訊資料", "通訊資料", context),
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
        unitLine(
          "電子郵件",
          email ?? "",
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine(
          "手機號碼",
          phone ?? "",
        ),
      ],
    ),
  );
}