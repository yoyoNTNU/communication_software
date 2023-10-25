part of 'chatroom_list_widget.dart';

class MainLine extends StatefulWidget {
  final String chatroomType;
  final String name;
  final int? groupPeopleCount;
  final bool isPinned;
  final bool isMuted;

  const MainLine(
      {super.key,
      required this.chatroomType,
      this.groupPeopleCount,
      required this.isMuted,
      required this.isPinned,
      required this.name});
  @override
  State<MainLine> createState() => _MainLineState();
}

class _MainLineState extends State<MainLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            widget.name,
            style: AppStyle.header(level: 2),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (widget.chatroomType == "group")
          const SizedBox(
            width: 4,
          ),
        if (widget.chatroomType == "group")
          Container(
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppStyle.teal),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/user_teal.png",
                  width: 12,
                  height: 18,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  widget.groupPeopleCount!.toString(),
                  style: AppStyle.info(level: 2, color: AppStyle.teal),
                ),
              ],
            ),
          ),
        if (widget.isPinned)
          const SizedBox(
            width: 4,
          ),
        if (widget.isPinned)
          Container(
            width: 20,
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppStyle.yellow[200]!),
            ),
            child: Image.asset("assets/icons/pin_yellow.png"),
          ),
        if (widget.isMuted)
          const SizedBox(
            width: 4,
          ),
        if (widget.isMuted)
          Container(
            width: 20,
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFFFE7E6)),
            ),
            child: Image.asset("assets/icons/mute_pink.png"),
          )
      ],
    );
  }
}
