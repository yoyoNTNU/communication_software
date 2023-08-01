import 'package:flutter/material.dart';
import 'package:proj/pages/friends_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE6F0F5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset('assets/images/Background.png').image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.60,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 24,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      fixedSize: const Size(95, 24),
                      backgroundColor: const Color(0x01858585),
                    ),
                    icon: Image.asset('assets/icons/Edit.png'),
                    onPressed: () {},
                    label: const Text(
                      '編輯資料',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFFFFC93C)),
                  height: 4,
                ),
                const Positioned(
                  top: 90,
                  left: 12,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/Avatar.jpg'),
                    // child: const Text('e'),
                  ),
                ),
              ],
            ),

            // TODO: 好友列表 and 群組列表
            const FriendsList(),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(127, 40),
                foregroundColor: const Color(0xFFFB0C06),
                backgroundColor: Colors.white,
              ),
              icon: Image.asset('assets/icons/Sign_out_circle.png'),
              onPressed: () {},
              label: const Text(
                '登出',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFB0C06),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
