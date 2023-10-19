part of 'chatroom_widget.dart';

class SelectBar extends StatefulWidget {
  final bool senderIsMe;

  const SelectBar({
    super.key,
    required this.senderIsMe,
  });

  @override
  State<SelectBar> createState() => _SelectBarState();
}

class _SelectBarState extends State<SelectBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
