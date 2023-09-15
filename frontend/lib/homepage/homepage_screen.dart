import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/homepage/friends_list.dart';
import 'package:proj/homepage/groups_list.dart';
import 'package:proj/homepage/homepage_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Text('Action'),
          onPressed: () {},
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 214,
                      color: AppStyle.blue[50]),
                  Container(
                      width: double.infinity,
                      height: 184,
                      color: AppStyle.yellow),
                  Container(
                      width: double.infinity,
                      height: 180,
                      color: AppStyle.white),
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            Image.asset('assets/images/Background.png').image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.40,
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 120,
                          color: Colors.transparent),
                      Container(
                          width: double.infinity,
                          height: 60,
                          color: AppStyle.gray[600]!.withOpacity(0.6)),
                    ],
                  ),
                  Positioned(
                    top: 12,
                    right: 24,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/home'),
                      style: AppStyle.primaryBtn(
                        backgroundColor: AppStyle.gray[600]!.withOpacity(1),
                        pressedColor: AppStyle.gray[800]!.withOpacity(0.4),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset("assets/icons/Edit.png"),
                          ),
                          const SizedBox(width: 8),
                          const Text("編輯資料"),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 12,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          Image.asset('assets/images/Avatar.jpg').image,
                    ),
                  ),
                  Positioned(
                    top: 124.5,
                    left: 154,
                    child: Text(
                      'Exp. Message',
                      style: AppStyle.header(color: AppStyle.white),
                    ),
                  ),
                  const Positioned(
                    top: 154.5,
                    left: 154,
                    child: CopyableText(),
                  ),
                ],
              ),

              // TODO: 好友列表 and 群組列表
              Container(
                padding: const EdgeInsets.only(
                  top: 18,
                  bottom: 300,
                  left: 16,
                  right: 16,
                ),
                color: AppStyle.blue[50],
                child: Column(
                  children: [
                    FriendsList(),
                    const SizedBox(
                      height: 24,
                    ),
                    GroupsList(),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      style: AppStyle.primaryBtn(
                          backgroundColor: AppStyle.white,
                          pressedColor: AppStyle.sea,
                          textColor: AppStyle.red),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/icons/Sign_out_circle.png"),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("登出"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
