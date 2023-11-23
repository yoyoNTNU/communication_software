part of 'app_setting_widget.dart';

Widget logoutBtn(BuildContext context) {
  return OutlinedButton(
    onPressed: () async {
      int responseCode;
      try {
        responseCode = await AppSettingAPI.logOut();
        if (responseCode == 200 && context.mounted) {
          Navigator.popAndPushNamed(context, '/login');
        }
      } catch (e) {
        print('API request error: $e');
      }
    },
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
