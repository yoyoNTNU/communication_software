part of 'homepage_widget.dart';

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
      //print("g:API");
      try {
        final List<Map<String, dynamic>> info = await GetInfoAPI.getGroup();
        if (mounted) {
          setState(() {
            groupList = info;
          });
          await DatabaseHelper.instance.cacheGroupData(groupList);
        }
      } catch (e) {
        print('API request error: $e');
      }
    } else {
      //print("g:Cache");
    }
    widget.onLoaded();
    if (mounted) {
      setState(() {});
    }
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
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    group['name'],
                                    style: AppStyle.header(
                                        level: 3, color: AppStyle.gray[700]!),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 18,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppStyle.teal),
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.transparent),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icons/user_blue.png",
                                        width: 12,
                                        height: 18,
                                      ),
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
