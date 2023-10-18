part of 'homepage_widget.dart';

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
      //print("f:API");
      try {
        final List<Map<String, dynamic>> info = await GetInfoAPI.getFriend();
        if (mounted) {
          setState(() {
            friendList = info;
          });
          await DatabaseHelper.instance.cacheFriendData(friendList);
        }
      } catch (e) {
        print('API request error: $e');
      }
    } else {
      //print("f:Cache");
    }
    if (mounted) {
      setState(() {});
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
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              friend['introduction'] ?? "",
                              style: AppStyle.info(color: AppStyle.gray[600]!),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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
