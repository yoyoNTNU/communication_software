import 'package:flutter/material.dart';

class GroupsList extends StatefulWidget {
  const GroupsList({super.key});

  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(
      title: Text('群組列表'),
      subtitle: Text('2 個群組'),
      children: <Widget>[
        ListTile(title: Text('CSIE 技術研討會')),
        ListTile(title: Text('垃圾幹話群')),
      ],
    );
  }
}
