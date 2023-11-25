part of 'group_widget.dart';

class MemberCard extends StatefulWidget {
  final int id;
  final String? avatar;
  final String name;
  final bool isSelected; // Changed from 'check' to 'isSelected' for clarity
  final void Function(bool) onRadioChanged; // Callback to handle radio changes

  const MemberCard({
    super.key,
    required this.id,
    required this.avatar,
    required this.name,
    required this.isSelected,
    required this.onRadioChanged,
  });

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the onRadioChanged callback with the new selection state
        // widget.onRadioChanged(!widget.isSelected);
      },
      child: Container(
        height: 72,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppStyle.white),
        child: Row(
          children: [
            const SizedBox(width: 24.0),
            Checkbox(
              value: widget.isSelected, // The current value of the checkbox
              onChanged: (bool? newValue) {
                // Call the onRadioChanged callback with the new selection state
                if (newValue != null) {
                  widget.onRadioChanged(newValue);
                }
              },
              activeColor: AppStyle.teal,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(children: [
                  ClipOval(
                      clipBehavior: Clip.hardEdge,
                      child: widget.avatar != null
                          ? Image.network(
                              widget.avatar!,
                              width: 48,
                              height: 48,
                            )
                          : Image.asset('assets/images/avatar.png')),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget.name,
                      style: AppStyle.header(level: 2),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}




// part of 'group_widget.dart';

// class MemberCard extends StatefulWidget {
//   final int id;
//   final String? avatar;
//   final String name;
//   final bool check;
//   final void Function() onTap;

//   const MemberCard({
//     super.key,
//     required this.id,
//     required this.avatar,
//     required this.name,
//     required this.check,
//     required this.onTap,
//   });
//   @override
//   State<MemberCard> createState() => _MemberCardState();
// }

// class _MemberCardState extends State<MemberCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//           height: 72,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4), color: AppStyle.white),
//           child: Row(
//             children: [
//               Container(
//                 width: 48,
//                 padding: const EdgeInsets.only(left: 24),
//                 child: widget.check
//                     ? Image.asset("assets/icons/select.png")
//                     : Image.asset("assets/icons/unselect.png"),
//               ),
//               Expanded(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   child: Row(children: [
//                     ClipOval(
//                         clipBehavior: Clip.hardEdge,
//                         child: widget.avatar != null
//                             ? Image.network(
//                                 widget.avatar!,
//                                 width: 48,
//                                 height: 48,
//                               )
//                             : Image.asset('assets/images/avatar.png')),
//                     const SizedBox(
//                       width: 16,
//                     ),
//                     Expanded(
//                       child: Text(
//                         widget.name,
//                         style: AppStyle.header(level: 2),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       ),
//                     )
//                   ]),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }
