import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/group/group_api.dart';
import 'package:proj/group/group_widget.dart';
import 'package:proj/widget.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final _searchController = TextEditingController();
  int step = 0;
  List<Map<String, dynamic>> friendList = [];
  List<Map<String, dynamic>> copyFriendList = [];

  Future<void> _getFriendList() async {
    showLoading(context);
    try {
      final List<Map<String, dynamic>> info = await GetInfoAPI.getFriend();
      setState(() {
        friendList = info;
        copyFriendList = friendList;
      });
    } catch (e) {
      print('API request error: $e');
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _getFriendList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.blue[50],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (step == 0) {
              Navigator.popAndPushNamed(context, '/home');
            } else {
              setState(() {
                --step;
              });
            }
          },
          child: Image.asset("assets/icons/left.png"),
        ),
        title: Text(
          '創建群組',
          style: AppStyle.header(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 28,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: AppStyle.blue[50],
            child: Text(
              "已選擇 ${copyFriendList.where((friend) => friend["check"] == true).length} 位成員",
              style: AppStyle.body(color: AppStyle.gray),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 52,
            width: double.infinity,
            color: AppStyle.white,
            child: OutlinedButton(
              style: AppStyle.secondaryBtn(),
              onPressed: () {
                setState(() {
                  ++step;
                });
              },
              child: const Text("下一步"),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            expandedHeight: step == 0 ? 122.0 : 62,
            collapsedHeight: step == 0 ? 122.0 : 62,
            backgroundColor: AppStyle.white,
            title: Container(
              color: AppStyle.white,
              child: StepProgressIndicator(
                currentStep: step,
              ),
            ),
            centerTitle: true,
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 62),
                if (step == 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24),
                    height: 60,
                    child: AppTextField(
                      controller: _searchController,
                      onTapX: () {
                        setState(() {
                          friendList = List.from(copyFriendList);

                          // print(friendList);
                          // print(copyFriendList);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          List<Map<String, dynamic>> filteredList = [];
                          if (value.isNotEmpty) {
                            filteredList = copyFriendList.where((friend) {
                              String friendName =
                                  friend["nickname"].toLowerCase();
                              return friendName.contains(value.toLowerCase());
                            }).toList();
                          } else {
                            filteredList = List.from(copyFriendList);
                          }
                          setState(() {
                            friendList = filteredList;
                            // print(filteredList);
                            // print(friendList);
                            // print(copyFriendList);
                          });
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 16,
              color: Colors.transparent,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(friendList.length, (int index) {
                return Column(
                  children: [
                    MemberCard(
                      id: friendList[index]["id"],
                      avatar: friendList[index]["photo"],
                      name: friendList[index]["nickname"],
                      check: friendList[index]["check"],
                      onTap: () {
                        setState(() {
                          friendList[index]["check"] =
                              !friendList[index]["check"];
                          // print(friendList);
                          // print(copyFriendList);
                        });
                      },
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 12,
                    )
                  ],
                );
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 4,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
