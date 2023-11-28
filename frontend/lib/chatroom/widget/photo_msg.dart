part of 'chatroom_widget.dart';

class PhotoMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? messageID;
  final int? senderID;
  final int? readCount;
  final String content;
  final String msgTime;
  final void Function()? onLongPressed;

  const PhotoMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.readCount,
    required this.content,
    required this.msgTime,
    this.onLongPressed,
    required this.messageID,
  });

  @override
  State<PhotoMsg> createState() => _PhotoMsgState();
}

class _PhotoMsgState extends State<PhotoMsg> {
  String read = "";

  @override
  void didChangeDependencies() async {
    if (widget.senderIsMe) {
      String temp = readCount(widget.readCount, widget.chatroomType);
      setState(() {
        read = temp;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        fullViewImage(context, widget.content, isNeedDownload: true);
      },
      onLongPress: widget.messageID == null ? null : widget.onLongPressed,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: screenWidth * 0.70, minWidth: 120),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.senderIsMe ? AppStyle.blue[400] : AppStyle.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 29,
                  height: 18,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: widget.senderIsMe
                            ? AppStyle.yellow[300]!
                            : AppStyle.yellow[600]!),
                  ),
                  child: Text(
                    "相片",
                    style: AppStyle.info(
                        level: 2,
                        color: widget.senderIsMe
                            ? AppStyle.yellow[300]!
                            : AppStyle.yellow[600]!),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 200,
                            width: screenWidth * 0.7,
                            color: widget.senderIsMe
                                ? AppStyle.blue[400]
                                : AppStyle.white,
                          ),
                          Image.network(
                            widget.content,
                            fit: BoxFit.contain,
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                "$read${widget.msgTime}",
                style: AppStyle.info(
                    level: 2,
                    color: widget.senderIsMe
                        ? AppStyle.gray[100]!
                        : AppStyle.gray[500]!),
              ),
            )
          ],
        ),
      ),
    );
  }
}
