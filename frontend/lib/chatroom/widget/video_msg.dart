part of 'chatroom_widget.dart';

class VideoMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? messageID;
  final int? senderID;
  final int? readCount;
  final String content;
  final String msgTime;
  final void Function()? onLongPressed;

  const VideoMsg({
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
  State<VideoMsg> createState() => _VideoMsgState();
}

class _VideoMsgState extends State<VideoMsg> {
  late final Player player = Player();
  late final VideoController controller = VideoController(player);
  double _height = 0;
  double _width = 0;
  String read = "";

  @override
  void didChangeDependencies() async {
    if (widget.senderIsMe) {
      String temp = readCount(widget.readCount, widget.chatroomType);
      setState(() {
        read = temp;
      });
    }
    final playable = Media(widget.content);
    await player.open(playable);
    await controller.waitUntilFirstFrameRendered;
    await player.setVolume(0.0);
    if (!mounted) return;
    setState(() {
      _height = controller.rect.value?.height.toDouble() ?? 0;
      _width = controller.rect.value?.width.toDouble() ?? 0;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              //要有下載按鈕
              player.setVolume(50.0);
              return Stack(
                children: [
                  Video(
                    controller: controller,
                  ),
                  Positioned(
                    top: 24,
                    right: 24,
                    child: GestureDetector(
                      onTap: () {
                        player.setVolume(0.0);
                        Navigator.of(context).pop();
                      },
                      child: Image.asset("assets/icons/x_white.png"),
                    ),
                  ),
                ],
              );
            },
          ),
        );
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
                    "影片",
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
                  child: AspectRatio(
                    aspectRatio:
                        _height == 0 || _width == 0 ? 1 / 1 : _width / _height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Video(
                        controller: controller,
                        controls: (state) {
                          return Center(
                            child: IconButton(
                              onPressed: () {
                                state.widget.controller.player.playOrPause();
                              },
                              icon: StreamBuilder(
                                stream: state
                                    .widget.controller.player.stream.playing,
                                builder: (context, playing) => Icon(
                                  playing.data == true
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,
                                  color: AppStyle.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
