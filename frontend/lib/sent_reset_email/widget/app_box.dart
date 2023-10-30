part of 'sent_reset_email_widget.dart';

class AppBox extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onClicked;
  final bool needLeftButton;
  const AppBox({
    super.key,
    required this.title,
    required this.content,
    this.onClicked,
    required this.needLeftButton,
  });
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
          Row(
            children: [
              if (needLeftButton)
                GestureDetector(
                    onTap: () {
                      if (onClicked != null) {
                        onClicked!();
                      }
                    },
                    child: Image.asset(
                      'assets/icons/left.png',
                      width: 24,
                      height: 24,
                    )),
              Expanded(
                  child: Center(
                      child: Text(title,
                          style: AppStyle.header(
                              level: 2, color: AppStyle.gray.shade700)))),
              if (needLeftButton)
                const SizedBox(
                  width: 24,
                  height: 24,
                )
            ],
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }
}