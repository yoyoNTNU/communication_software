import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/app_setting/pop_widget/pop_prob_fb.dart';

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
Widget regardingUS() {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("關於我們"),
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
          Container(
            height: 192,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.asset(
              "assets/images/Avatar.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "我們好棒喔~",
            style: AppStyle.info(level: 2, color: AppStyle.gray[700]!),
          ),
        ]
      )
  );       
}

Widget versionInfo() {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("版本資訊"),
          const SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.gray[100],
          ),
          unitLine(
            "版本",
            "1.2.8",
          ),
        ]
      )
  );
}
Widget loginNotification() {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("登入通知"),
          const SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.gray[100],
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
            height: 44,
            child: Row(children: [
              SizedBox(
                width: 96,
                child: Text(
                  "開啟/關閉",
                  style: AppStyle.header(level: 3, color: AppStyle.gray[700]!),
                ),
              ),
            ])
          )
        ]
      )
  );
}
Widget reportProblem(BuildContext context) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("回報問題"),
          const SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.gray[100],
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const PopProbFB(),
              );
            },
            style: AppStyle.popUpBtn(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/icons/Bell.png"),
                const SizedBox(
                  width: 8,
                ),
                const Text("問題/反饋")
              ],
            ),
          ),
        ]
      )
  );
}
Widget logoutBtn() {
  return OutlinedButton(
    onPressed: () {},
    style: AppStyle.dangerBtn().copyWith(
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(95, 40),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/icons/Sign_out_circle.png"),
        const SizedBox(
          width: 8,
        ),
        const Text("登出")
      ],
    ),
  );
}