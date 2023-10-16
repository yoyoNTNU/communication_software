part of 'edit_page_widget.dart';

void showFail(BuildContext context, String? hintText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "修改失敗，請再試一次 提醒您：$hintText",
        style: AppStyle.body(color: AppStyle.white),
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}