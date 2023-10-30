part of 'login_widget.dart';

class AppBox extends StatelessWidget {
  final String title;
  final Widget content;
  const AppBox({super.key, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: AppStyle.black.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title,
              style: AppStyle.header(level: 2, color: AppStyle.gray.shade700)),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }
}