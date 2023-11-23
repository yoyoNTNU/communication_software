part of 'chatroom_widget.dart';

class MemberThumbnailList extends StatefulWidget {
  final int chatroomID;
  final bool isShowMemberThumbnail;
  final int memberCount;
  final List<dynamic> memberData;
  final double height;

  const MemberThumbnailList({
    super.key,
    required this.chatroomID,
    required this.isShowMemberThumbnail,
    required this.memberCount,
    required this.memberData,
    required this.height,
  });

  @override
  State<MemberThumbnailList> createState() => _MemberThumbnailListState();
}

class _MemberThumbnailListState extends State<MemberThumbnailList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isShowMemberThumbnail)
          Container(
            padding: const EdgeInsets.fromLTRB(24, 3, 24, 4),
            height: widget.height - 1,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppStyle.teal),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //電腦版只能透過觸控板用兩指滑動 滑鼠沒辦法達到這個功能
                    itemCount: widget.memberCount,
                    itemBuilder: (BuildContext context, int index) {
                      var member = widget.memberData[index];
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showProfileDialog(context, id: member["id"]);
                            },
                            child: ClipOval(
                              clipBehavior: Clip.hardEdge,
                              child: member["avatar"] == null
                                  ? Image.asset(
                                      "assets/images/avatar.png",
                                      width: 32,
                                      height: 32,
                                    )
                                  : Image.network(
                                      member["avatar"],
                                      width: 32,
                                      height: 32,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 24,
                  child: widget.height == 41
                      ? IconButton(
                          splashRadius: 12,
                          padding: EdgeInsets.zero,
                          splashColor: AppStyle.white,
                          focusColor: AppStyle.white,
                          hoverColor: AppStyle.white,
                          highlightColor: AppStyle.white,
                          alignment: Alignment.centerRight,
                          iconSize: 24,
                          onPressed: () {
                            print("進入成員列表");
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 24,
                          ),
                        )
                      : null,
                )
              ],
            ),
          ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppStyle.blue[100],
        ),
      ],
    );
  }
}
