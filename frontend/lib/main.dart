import 'package:flutter/material.dart';

void main() => runApp(const ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavBar());
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.table_chart_outlined),
            label: '個人主頁',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            label: '聊天室',
          ),
        ],
      ),
      body: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  height: 180,
                  child: Image.asset(
                    'assets/images/Mask.png',
                  ),
                ),
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/Avatar.jpg'),
                  // child: const Text('e'),
                ),
              ],
            ),
            const Divider(
              height: 50,
              thickness: 4,
              indent: 0,
              endIndent: 0,
              color: Colors.yellow,
            ),
            Row(children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.group_add),
                label: const Text('新增好友'),
                onPressed: pass,
              ),
              TextButton.icon(
                icon: const Icon(Icons.group),
                label: const Text('新增好友'),
                onPressed: pass,
              ),
            ]),
          ],
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('聊天室頁面'),
        ),
      ][currentPageIndex],
    );
  }
}

void pass() {}
