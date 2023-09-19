import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj/style.dart';
import 'package:proj/homepage/homepage_api.dart';
import 'package:proj/main.dart';

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
      duration: Duration(seconds: 1),
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
                "# $text_",
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

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Image.asset('assets/animations/loading.gif')],
      ),
    );
  }
}

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Map<String, dynamic>> friendList = [];

  Future<void> _getFriendList() async {
    try {
      final List<Map<String, dynamic>> info = await GetInfoAPI.getFriend();
      setState(() {
        friendList = info;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getFriendList();
  }

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
                style: AppStyle.header(level: 2, color: AppStyle.gray[700]!),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${friendList.length}位朋友",
                style: AppStyle.info(color: AppStyle.teal),
              ),
            ],
          ),
          children: friendList.isNotEmpty
              ? <Widget>[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppStyle.gray[100],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: friendList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var friend = friendList[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            title: Text(
                              friend['nickname'],
                              style: AppStyle.header(
                                  level: 3, color: AppStyle.gray[700]!),
                            ),
                            subtitle: Text(
                              friend['introduction'] ?? "",
                              style: AppStyle.info(color: AppStyle.gray[600]!),
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: friend["photo"] != null
                                  ? NetworkImage(
                                          "https://$host${friend['photo']}")
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/images/Avatar.png'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: AppStyle.gray[100],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ]
              : <Widget>[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppStyle.gray[100],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    height: 88,
                    child: Image.asset("assets/images/fail_logo.png"),
                  ),
                  Text(
                    "列表空空如也，趕快去新增好友吧！",
                    style: AppStyle.info(level: 2, color: AppStyle.gray[700]!),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppStyle.gray[100],
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
        ),
      ),
    );
  }
}

class GroupsList extends StatefulWidget {
  final VoidCallback onLoaded;
  const GroupsList({super.key, required this.onLoaded});

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
