import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj/style.dart';

class CopyableText extends StatelessWidget {
  final String text_;
  const CopyableText({
    super.key,
    required this.text_,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text_)); //換成API
    const snackBar = SnackBar(
      content: Text('已將ID複製到剪貼板'),
      duration: Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _copyToClipboard(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.blue[50],
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            children: [
              Text(
                '# ',
                style: AppStyle.info(color: AppStyle.blue[300]!),
              ),
              Text(
                text_,
                style: AppStyle.info(color: AppStyle.blue[300]!),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 13,
                height: 13,
                child: Image.asset("assets/icons/Copy.png"),
              )
            ],
          ),
        ));
  }
}

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          unselectedWidgetColor: AppStyle.blue,
          dividerColor: Colors.transparent,
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '好友列表',
                    style:
                        AppStyle.header(level: 2, color: AppStyle.gray[700]!),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "5位朋友",
                    style: AppStyle.info(color: AppStyle.teal),
                  ),
                ],
              ),
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Adam',
                    style:
                        AppStyle.header(level: 3, color: AppStyle.gray[700]!),
                  ),
                  leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/Avatar.png'),
                      backgroundColor: Colors.transparent),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppStyle.gray[100],
                ),
                ListTile(title: Text('Bob')),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppStyle.gray[100],
                ),
                ListTile(title: Text('Ccccc')),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppStyle.gray[100],
                ),
                ListTile(title: Text('煞氣的台灣人')),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppStyle.gray[100],
                ),
                ListTile(title: Text('>>>>ooo<<<<')),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppStyle.gray[100],
                ),
                Container(
                  height: 16,
                  color: AppStyle.white,
                ),
              ],
            )));
  }
}

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
