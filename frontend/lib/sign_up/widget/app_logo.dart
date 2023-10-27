part of 'sign_up_widget.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 120,
          ),
          Text(
            'ExpressMessage',
            textAlign: TextAlign.center,
            style: AppStyle.header(level: 2, color: AppStyle.blue),
          ),
        ],
      ),
    );
  }
}
