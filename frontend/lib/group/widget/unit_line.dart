part of 'group_widget.dart';

Widget unitLine(String key, TextEditingController controller) {
  final FocusNode focusNode = FocusNode();
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
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: AppStyle.body(
              level: 2, color: AppStyle.gray.shade900, weight: FontWeight.w500),
          decoration: InputDecoration(
            hintStyle: AppStyle.body(level: 2, color: AppStyle.gray.shade500),
            filled: true,
            fillColor: AppStyle.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.gray, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.blue, width: 1.25),
            ),
          ),
        ),
      )
    ]),
  );
}