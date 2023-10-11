part of 'group_widget.dart';

void showSuccess(BuildContext context, String? type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '編輯$type成功，資訊已更新',
        style: AppStyle.body(color: AppStyle.white),
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}