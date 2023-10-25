import 'package:flutter/material.dart';
import 'package:proj/homepage/homepage_screen.dart';
import 'package:proj/chatroom_list/chatroom_list_screen.dart';
import 'package:proj/style.dart';
import 'package:proj/data.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    (() async {
      if (mounted) {
        int? index = await DatabaseHelper.instance.getHomepageIndex();
        if (index == null) {
          index = 0;
          await DatabaseHelper.instance.setHomepageIndex(0);
        }
        setState(() {
          currentPageIndex = index!;
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppStyle.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 64,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (int index) async {
          await DatabaseHelper.instance.setHomepageIndex(index);
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Image.asset("assets/icons/Table_gray.png"),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "主頁",
                  style: AppStyle.caption(
                    level: 2,
                    color: AppStyle.gray[600]!,
                  ),
                )
              ],
            ),
            selectedIcon: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Image.asset("assets/icons/Table_blue.png"),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "主頁",
                  style: AppStyle.caption(level: 2, color: AppStyle.blue),
                )
              ],
            ),
            label: '主頁',
            tooltip: '',
          ),
          NavigationDestination(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Image.asset("assets/icons/Chat_gray.png"),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "聊天室",
                  style: AppStyle.caption(
                      level: 2,
                      color: AppStyle.gray[600]!,
                      weight: FontWeight.w700),
                )
              ],
            ),
            selectedIcon: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Image.asset("assets/icons/Chat_blue.png"),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "聊天室",
                  style: AppStyle.caption(
                      level: 2, color: AppStyle.blue, weight: FontWeight.w700),
                )
              ],
            ),
            label: '聊天室',
            tooltip: '',
          ),
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const ChatroomListPage(),
      ][currentPageIndex],
    );
  }
}
