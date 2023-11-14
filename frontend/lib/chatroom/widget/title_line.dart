part of 'chatroom_widget.dart';

class TitleLine extends StatefulWidget {
  final String chatroomType;
  final String name;
  final int? friendID;
  final int? groupPeopleCount;
  final bool isPinned;
  final bool isMuted;
  final bool isExpanded;
  final void Function() onTapMemberCount;

  const TitleLine({
    super.key,
    required this.chatroomType,
    this.groupPeopleCount,
    this.friendID,
    required this.isMuted,
    required this.isPinned,
    required this.name,
    required this.isExpanded,
    required this.onTapMemberCount,
  });
  @override
  State<TitleLine> createState() => _TitleLineState();
}

class _TitleLineState extends State<TitleLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: GestureDetector(
            onTap: () {
              if (widget.chatroomType == "group") {
                widget.onTapMemberCount();
              } else {
                showProfileDialog(context, id: widget.friendID!);
              }
            },
            child: Text(
              widget.name,
              style: AppStyle.header(level: 2),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        if (widget.chatroomType == "group")
          const SizedBox(
            width: 4,
          ),
        if (widget.chatroomType == "group")
          GestureDetector(
            onTap: widget.onTapMemberCount,
            child: Container(
              height: 18,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              decoration: BoxDecoration(
                color: widget.isExpanded ? AppStyle.sea : AppStyle.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: widget.isExpanded ? AppStyle.sea : AppStyle.teal,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.isExpanded
                        ? "assets/icons/user_blue.png"
                        : "assets/icons/user_teal.png",
                    width: 12,
                    height: 18,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    widget.groupPeopleCount!.toString(),
                    style: AppStyle.info(
                      level: 2,
                      color: widget.isExpanded ? AppStyle.blue : AppStyle.teal,
                    ),
                  ),
                ],
              ),
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
