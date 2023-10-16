part of 'edit_page_widget.dart';

Widget title(String text, [String? tips, BuildContext? context]) {
  TextStyle linkStyle = TextStyle(
    color: AppStyle.blue[200]!,
    fontSize: 12,
    fontFamily: 'NotoSansTC',
    fontWeight: FontWeight.w300,
    letterSpacing: 0.4,
    decoration: TextDecoration.underline,
    decorationColor: AppStyle.blue[200]!,
  );
  TapGestureRecognizer tapDirect;
  if (tips != null && context != null) {
    tapDirect = TapGestureRecognizer()
      ..onTap = () {
        //TODO 改為回報問題頁面
        Navigator.pushNamed(context, '/home');
      };
  } else {
    tapDirect = TapGestureRecognizer()..onTap = () {};
  }
  return tips == null
      ? SizedBox(
          width: double.infinity,
          child: Text(
            text,
            style: AppStyle.header(color: AppStyle.gray[700]!),
            textAlign: TextAlign.left,
          ),
        )
      : Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: AppStyle.header(color: AppStyle.gray[700]!),
                textAlign: TextAlign.left,
              ),
            ),
            Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                showDuration: const Duration(seconds: 10),
                richMessage: TextSpan(children: [
                  TextSpan(
                      text: "$tips無法修改\n若需修改請至 ",
                      style: AppStyle.info(color: AppStyle.white)),
                  TextSpan(
                    text: '回報問題',
                    style: linkStyle,
                    recognizer: tapDirect,
                  ),
                  TextSpan(
                      text: " 提出修改申請",
                      style: AppStyle.info(color: AppStyle.white)),
                ]),
                child: Image.asset("assets/icons/Tips.png")),
          ],
        );
}