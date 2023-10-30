part of 'homepage_widget.dart';

class CopyableText extends StatelessWidget {
  final String text_;
  const CopyableText({
    super.key,
    required this.text_,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text_)); //換成API
    SnackBar snackBar = SnackBar(
      content: Text(
        '已將ID複製到剪貼板',
        style: AppStyle.body(color: AppStyle.white),
      ),
      duration: const Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _copyToClipboard(context);
        },
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 164,
          ),
          decoration: BoxDecoration(
            color: AppStyle.blue[50],
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  "# $text_",
                  style: AppStyle.info(color: AppStyle.blue[300]!),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 13,
                height: 13,
                child: Image.asset("assets/icons/copy.png"),
              )
            ],
          ),
        ));
  }
}
