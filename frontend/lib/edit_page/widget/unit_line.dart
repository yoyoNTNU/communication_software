part of 'edit_page_widget.dart';

Widget unitLine(String key, String value, [VoidCallback? onPress]) {
  return Container(
    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
    height: 44,
    child: Row(children: [
      SizedBox(
        width: 96,
        child: Text(
          key,
          style: AppStyle.header(level: 3, color: AppStyle.gray[700]!),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: AppStyle.body(color: AppStyle.gray[500]!),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      if (onPress != null)
        TextButton(
          style: AppStyle.textBtn(),
          onPressed: onPress,
          child: const Text(
            '修改',
          ),
        ),
    ]),
  );
}