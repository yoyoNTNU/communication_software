part of 'chatroom_widget.dart';

class Menu extends StatefulWidget {
  final int chatroomID;

  const Menu({
    super.key,
    required this.chatroomID,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 50,
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => ChatroomInfo(
        //               chatroomID: widget.chatroomID,
        //             ),
        //           ),
        //         );
        //       },
        //       icon: Icon(
        //         Icons.info_outline,
        //         color: Colors.white,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => ChatroomSetting(
        //               chatroomID: widget.chatroomID,
        //             ),
        //           ),
        //         );
        //       },
        //       icon: Icon(
        //         Icons.settings,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
