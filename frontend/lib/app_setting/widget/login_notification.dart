part of 'app_setting_widget.dart';

class LoginNotification extends StatefulWidget {
  const LoginNotification({super.key});

  @override
  State<LoginNotification> createState() => _LoginNotificationState();
}

class _LoginNotificationState extends State<LoginNotification> {
  bool _isChecked = true;
  int _responseCode = 400;

  Future<void> _modifyNoti({String? isLoginMail}) async {
    try {
      final int responseCode =
          await AppSettingAPI.modifyNoti(isLoginMail: isLoginMail);
      setState(() {
        _responseCode = responseCode;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(children: [
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
                  width: 146,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          "開啟/關閉",
                          style: AppStyle.header(
                              level: 3, color: AppStyle.gray[700]!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Switcher(
                        onChanged: (value) async {
                          setState(() {
                            _isChecked = value;
                          });
                          _isChecked == true
                              ? await _modifyNoti(isLoginMail: "true")
                              : await _modifyNoti(isLoginMail: "false");
                          if (_responseCode == 200) {
                            if (!context.mounted) return;
                            print("switcher成功");
                          } else {
                            if (!context.mounted) return;
                            print("switcher壞了");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ]))
        ]));
  }
}
