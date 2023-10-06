import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj/data.dart';
import 'package:proj/style.dart';
import 'package:proj/homepage/homepage_api.dart';

class CopyableText extends StatelessWidget {
  final String text_;
  const CopyableText({
    super.key,
    required this.text_,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text_)); //換成API
    SnackBar snackBar = SnackBar(
      content: Text(
        '已將ID複製到剪貼板',
        style: AppStyle.body(color: AppStyle.white),
      ),
      duration: const Duration(milliseconds: 1500),
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

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Map<String, dynamic>> friendList = [];

  Future<void> _getFriendList() async {
    friendList = await DatabaseHelper.instance.getCachedFriendData();

    if (friendList[0]['empty'] == true) {
      print("f:API");
      try {
        final List<Map<String, dynamic>> info = await GetInfoAPI.getFriend();
        setState(() {
          friendList = info;
        });
        await DatabaseHelper.instance.cacheFriendData(friendList);
      } catch (e) {
        print('API request error: $e');
      }
    } else {
      print("f:Cache");
    }
    setState(() {});
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
                                  ? NetworkImage(friend['photo'])
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
  List<Map<String, dynamic>> groupList = [];

  Future<void> _getGroupList() async {
    groupList = await DatabaseHelper.instance.getCachedGroupData();

    if (groupList[0]['empty'] == true) {
      print("g:API");
      try {
        final List<Map<String, dynamic>> info = await GetInfoAPI.getGroup();
        setState(() {
          groupList = info;
        });
        await DatabaseHelper.instance.cacheGroupData(groupList);
        widget.onLoaded();
      } catch (e) {
        print('API request error: $e');
      }
    } else {
      print("g:Cache");
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getGroupList();
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
                '群組列表',
                style: AppStyle.header(level: 2, color: AppStyle.gray[700]!),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${groupList.length}個群組",
                style: AppStyle.info(color: AppStyle.teal),
              ),
            ],
          ),
          children: groupList.isNotEmpty
              ? <Widget>[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppStyle.gray[100],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: groupList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var group = groupList[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            title: Row(
                              children: [
                                Text(
                                  group['name'],
                                  style: AppStyle.header(
                                      level: 3, color: AppStyle.gray[700]!),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppStyle.blue[50]!),
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.transparent),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/icons/user_blue.png"),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "${group['count']}",
                                        style: AppStyle.info(
                                            level: 2, color: AppStyle.teal),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: group["photo"] != null
                                  ? NetworkImage(group["photo"])
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
                    "列表空空如也，趕快去創建群組吧！",
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

class PrimeSelect extends StatelessWidget {
  const PrimeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(4),
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/edit');
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/Edit_blue.png"),
                      Text(
                        '編輯資料',
                        style: AppStyle.caption(
                          level: 2,
                          color: AppStyle.blue,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //TODO: push to friend request list page
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/User_add.png"),
                      Text(
                        '好友邀請',
                        style: AppStyle.caption(
                          level: 2,
                          color: AppStyle.blue,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //TODO: push to setting page
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/Setting.png"),
                      Text(
                        '設定',
                        style: AppStyle.caption(
                          level: 2,
                          color: AppStyle.blue,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}
