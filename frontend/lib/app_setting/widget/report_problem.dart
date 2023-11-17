part of 'app_setting_widget.dart';

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