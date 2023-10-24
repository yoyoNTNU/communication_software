part of 'chatroom_widget.dart';

class VoiceMsg extends StatefulWidget {
  final String chatroomType;
  final bool senderIsMe;
  final int? senderID;
  final String content;
  final String msgTime;
  final void Function()? onLongPressed;

  const VoiceMsg({
    super.key,
    required this.chatroomType,
    required this.senderIsMe,
    this.senderID,
    required this.content,
    required this.msgTime,
    this.onLongPressed,
  });

  @override
  State<VoiceMsg> createState() => _VoiceMsgState();
}

class _VoiceMsgState extends State<VoiceMsg> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration audioDuration = const Duration();
  Duration currentPosition = const Duration();
  bool onPlay = false;
  Widget noise = const SizedBox();

  Timer? timer1;
  Timer? timer2;

  @override
  void didChangeDependencies() async {
    await audioPlayer.setSourceUrl(widget.content);
    //audioplayers 套件目前有問題會報錯 但不影響
    final Duration? temp = await audioPlayer.getDuration();
    if (temp != null && mounted) {
      setState(() {
        audioDuration = temp;
      });
    }
    noise = ContactNoise(
      senderIsMe: widget.senderIsMe,
      recordDuration: audioDuration.inSeconds.toDouble(),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
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
                    "音訊",
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
                      IconButton(
                          iconSize: 36,
                          onPressed: () {
                            setState(
                              () {
                                onPlay = !onPlay;
                                if (onPlay) {
                                  audioPlayer.resume();
                                  timer1 = Timer.periodic(
                                      const Duration(seconds: 1), (timer) {
                                    if (currentPosition < audioDuration) {
                                      if (!mounted) return;
                                      setState(() {
                                        currentPosition +=
                                            const Duration(seconds: 1);
                                      });
                                    } else {
                                      if (!mounted) return;
                                      setState(() {
                                        currentPosition = const Duration();
                                        onPlay = false;
                                      });
                                      audioPlayer.stop();
                                      timer.cancel();
                                    }
                                  });
                                  timer2 = Timer.periodic(
                                      const Duration(milliseconds: 100),
                                      (timer) {
                                    if (currentPosition < audioDuration) {
                                      if (!mounted) return;
                                      setState(() {
                                        noise = ContactNoise(
                                          senderIsMe: widget.senderIsMe,
                                          recordDuration: audioDuration
                                              .inSeconds
                                              .toDouble(),
                                        );
                                      });
                                    } else {
                                      timer.cancel();
                                    }
                                  });
                                } else {
                                  if (timer1 != null && timer1!.isActive) {
                                    timer1!.cancel();
                                  }
                                  if (timer2 != null && timer2!.isActive) {
                                    timer2!.cancel();
                                  }
                                  audioPlayer.pause();
                                }
                              },
                            );
                          },
                          icon: onPlay
                              ? Icon(
                                  Icons.pause_circle_outline_rounded,
                                  color: widget.senderIsMe
                                      ? AppStyle.white
                                      : AppStyle.gray[700]!,
                                )
                              : Icon(
                                  Icons.play_circle_outline_rounded,
                                  color: widget.senderIsMe
                                      ? AppStyle.white
                                      : AppStyle.gray[700]!,
                                )),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          noise,
                          Text(
                            "剩餘時間：${(audioDuration - currentPosition).inMinutes} : ${((audioDuration - currentPosition).inSeconds - (audioDuration - currentPosition).inMinutes * 60).toString().padLeft(2, '0')}",
                            style: AppStyle.info(
                              level: 2,
                              color: widget.senderIsMe
                                  ? AppStyle.gray[100]!
                                  : AppStyle.gray[500]!,
                            ),
                          ),
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
