part of 'group_widget.dart';

class MemberCard extends StatefulWidget {
  final int id;
  final String? avatar;
  final String name;
  final bool check;
  final void Function() onTap;

  const MemberCard({
    super.key,
    required this.id,
    required this.avatar,
    required this.name,
    required this.check,
    required this.onTap,
  });
  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          height: 72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: AppStyle.white),
          child: Row(
            children: [
              Container(
                width: 48,
                padding: const EdgeInsets.only(left: 24),
                child: widget.check
                    ? Image.asset("assets/icons/select.png")
                    : Image.asset("assets/icons/unselect.png"),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(children: [
                  ClipOval(
                      child: widget.avatar != null
                          ? Image.network(
                              widget.avatar!,
                              width: 48,
                              height: 48,
                            )
                          : Image.asset('assets/images/Avatar.png')),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.name,
                    style: AppStyle.header(level: 2),
                  )
                ]),
              )
            ],
          )),
    );
  }
}