import 'package:flutter/material.dart';
import 'package:proj/pages/profile.dart';

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
            icon: ImageIcon(AssetImage('assets/icons/Table.png')),
            label: '個人主頁',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/Chat.png')),
            label: '聊天室',
          ),
        ],
      ),
      body: <Widget>[
        const ProfilePage(),
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
