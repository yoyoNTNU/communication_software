part of 'chatroom_widget.dart';

class FileMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final String content;
  final String msgTime;
  final void Function()? onLongPressed;

  const FileMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.content,
    required this.msgTime,
    this.onLongPressed,
  });

  @override
  State<FileMsg> createState() => _FileMsgState();
}

class _FileMsgState extends State<FileMsg> {
  String fileSize = "byte";
  @override
  void didChangeDependencies() async {
    try {
      var response = await http.head(Uri.parse(widget.content));
      double contentLength = double.parse(response.headers['content-length']!);

      if (contentLength / 1024 > 1) {
        contentLength /= 1024;
        fileSize = "KB";
      }
      if (contentLength / 1024 > 1) {
        contentLength /= 1024;
        fileSize = "MB";
      }
      if (contentLength / 1024 > 1) {
        contentLength /= 1024;
        fileSize = "GB";
      }
      if (mounted) {
        setState(() {
          fileSize = "${contentLength.toStringAsFixed(1)} $fileSize";
        });
      }
    } catch (e) {
      print('API request error: $e');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        print("這裡應該下載檔案");
      },
      onLongPress: widget.onLongPressed,
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
                    "檔案",
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
                  padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.senderIsMe
                          ? Image.asset("assets/icons/file.png")
                          : Image.asset("assets/icons/file_gray.png"),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.content.split('/').last,
                            style: AppStyle.body(
                                color: widget.senderIsMe
                                    ? AppStyle.white
                                    : AppStyle.gray[700]!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            fileSize,
                            style: AppStyle.info(
                                level: 2,
                                color: widget.senderIsMe
                                    ? AppStyle.gray[100]!
                                    : AppStyle.gray[500]!),
                          )
                        ],
                      )
                    ],
                  ),
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
                "${widget.senderIsMe ? readCount(2, widget.chatroomType) : ""}${widget.msgTime}",
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
