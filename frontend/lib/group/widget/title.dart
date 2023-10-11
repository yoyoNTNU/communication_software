part of 'group_widget.dart';

Widget title(String text) {
  return SizedBox(
    width: double.infinity,
    child: Text(
      text,
      style: AppStyle.header(color: AppStyle.gray[700]!),
      textAlign: TextAlign.left,
    ),
  );
}
