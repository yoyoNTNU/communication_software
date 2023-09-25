import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/edit_page/edit_page_pop_widget.dart';

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

Widget accountBox(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("帳戶資料"),
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
        unitLine("用戶密碼", "***********", () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditPassword(),
          );
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine(
          "用戶ID",
          "EXP-MSG",
        ),
      ],
    ),
  );
}

Widget infoBox(BuildContext context) {
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
        unitLine("使用者名稱", "Exp. Message", () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditName(),
          );
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine("個性簽名", "\\\OwwwwO///", () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditIntro(),
          );
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine("生日", "1900/05/01", () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditBD(),
          );
        }),
      ],
    ),
  );
}

Widget communityBox() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("通訊資料"),
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
          "flyingdollar.cheng@gmail.com",
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine(
          "手機號碼",
          "0912345678",
        ),
      ],
    ),
  );
}

class AvatarBox extends StatefulWidget {
  const AvatarBox({super.key});
  @override
  State<AvatarBox> createState() => _AvatarBoxState();
}

class _AvatarBoxState extends State<AvatarBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("個人頭像"),
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
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.popAndPushNamed(context, '/home'),
                  style: AppStyle.secondaryBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(95, 40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/img_box.png"),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("修改相片")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.popAndPushNamed(context, '/home'),
                  style: AppStyle.dangerBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(95, 40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/delete.png"),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("移除")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundBox extends StatefulWidget {
  const BackgroundBox({super.key});
  @override
  State<BackgroundBox> createState() => _BackgroundBoxState();
}

class _BackgroundBoxState extends State<BackgroundBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("背景相片"),
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
              "assets/images/Background.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.popAndPushNamed(context, '/home'),
                  style: AppStyle.secondaryBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(95, 40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/img_box.png"),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("修改相片")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.popAndPushNamed(context, '/home'),
                  style: AppStyle.dangerBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(95, 40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/delete.png"),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("移除")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
