part of 'app_setting_widget.dart';

Widget logoutBtn(BuildContext context) {
  return OutlinedButton(
    onPressed: () {
      Navigator.popAndPushNamed(context, '/login');
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