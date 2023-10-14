part of 'chatroom_list_widget.dart';

class SecondLine extends StatefulWidget {
  final String sender;
  final String messageType;
  final String messageContent;
  final String time;

  const SecondLine(
      {super.key,
      required this.sender,
      required this.messageType,
      required this.messageContent,
      required this.time});
  @override
  State<SecondLine> createState() => _SecondLineState();
}

class _SecondLineState extends State<SecondLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            widget.sender,
            style: AppStyle.info(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            widget.messageType == "string"
                ? widget.messageContent
                : msgTrans(widget.messageType),
            style: AppStyle.info(color: AppStyle.gray[600]!),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          timeTrans(widget.time),
          style: AppStyle.info(color: AppStyle.gray[500]!),
        )
      ],
    );
  }
}
