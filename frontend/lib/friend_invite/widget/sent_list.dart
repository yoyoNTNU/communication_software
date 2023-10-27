part of 'friend_invite_widget.dart';

class SentList extends StatefulWidget {
  final VoidCallback onLoaded;
  const SentList({super.key, required this.onLoaded});

  @override
  State<SentList> createState() => _SentListState();
}

class _SentListState extends State<SentList> {
  List<Map<String, dynamic>> sentList = [];

  Future<void> _getSentList() async {
    try {
      final List<Map<String, dynamic>> info = await GetInfoAPI.getSent();
      if (!mounted) return;
      setState(() {
        sentList = info;
      });
      widget.onLoaded();
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getSentList();
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
                '已寄出邀請',
                style: AppStyle.header(level: 2, color: AppStyle.gray[700]!),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${sentList.length}位用戶",
                style: AppStyle.info(color: AppStyle.teal),
              ),
            ],
          ),
          children: sentList.isNotEmpty
              ? <Widget>[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppStyle.gray[100],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: sentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var friend = sentList[index];
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
                    "目前沒有邀請喔~",
                    style: AppStyle.info(level: 2, color: AppStyle.gray[700]!),
                  ),
                  const SizedBox(
                    height: 8,
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
