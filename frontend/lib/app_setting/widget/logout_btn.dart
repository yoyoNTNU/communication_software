part of 'app_setting_widget.dart';

class LogOutBtn extends StatefulWidget {
  const LogOutBtn({super.key});

  @override
  State<LogOutBtn> createState() => _LogOutBtnState();
}

class _LogOutBtnState extends State<LogOutBtn> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              int responseCode;
              try {
                responseCode = await AppSettingAPI.logOut();
                if (responseCode == 200 && context.mounted) {
                  Navigator.popAndPushNamed(context, '/login');
                }
              } catch (e) {
                print('API request error: $e');
              }
              setState(() {
                _isLoading = false;
              });
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
          _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppStyle.white,
                  ))
              : Image.asset("assets/icons/Sign_out_circle.png"),
          const SizedBox(
            width: 8,
          ),
          const Text("登出")
        ],
      ),
    );
  }
}
