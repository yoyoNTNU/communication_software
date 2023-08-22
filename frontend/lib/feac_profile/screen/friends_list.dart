import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(
      title: Text('好友列表'),
      subtitle: Text('5 位朋友'),
      children: <Widget>[
        ListTile(title: Text('Adam')),
        ListTile(title: Text('Bob')),
        ListTile(title: Text('Ccccc')),
        ListTile(title: Text('煞氣的台灣人')),
        ListTile(title: Text('>>>>ooo<<<<')),
      ],
    );
  }
}
