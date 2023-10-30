part of 'sign_up_widget.dart';

class MainLine extends StatelessWidget {
  final String icon;
  final String type;

  const MainLine({super.key, required this.icon, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          type,
          style: AppStyle.caption(),
        )
      ],
    );
  }
}