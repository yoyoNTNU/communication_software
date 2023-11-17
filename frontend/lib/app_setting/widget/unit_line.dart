part of 'app_setting_widget.dart';

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
        ),
      ),
      if (onPress != null)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: TextButton(
            onPressed: onPress,
            child: Text(
              '修改',
              style: AppStyle.caption(color: AppStyle.teal),
            ),
          ),
        )
    ]),
  );
}