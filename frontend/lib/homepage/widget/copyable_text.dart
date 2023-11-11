part of 'homepage_widget.dart';

class CopyableText extends StatelessWidget {
  final String text_;
  const CopyableText({
    super.key,
    required this.text_,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          copyToClipboard(context, text_);
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
