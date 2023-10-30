part of 'sign_up_widget.dart';

class SecLine extends StatelessWidget {
  final bool isPass;
  final String type;

  const SecLine({super.key, required this.isPass, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 24,
        height: 24,
      ),
      isPass
          ? Image.asset(
              'assets/icons/pass.png',
              width: 24,
              height: 24,
            )
          : Image.asset(
              'assets/icons/not_pass.png',
              width: 24,
              height: 24,
            ),
      const SizedBox(width: 8),
      Text(
        type,
        textAlign: TextAlign.left,
        style: AppStyle.caption(
            color: isPass ? Colors.lightGreenAccent[400]! : AppStyle.red),
      ),
    ]);
  }
}
