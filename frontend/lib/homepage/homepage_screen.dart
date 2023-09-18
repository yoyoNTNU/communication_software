import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/homepage/homepage_widget.dart';
import 'package:proj/homepage/homepage_api.dart';
import 'package:proj/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> info_ = {};

  Future<void> _info() async {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      );
    });
    try {
      final Map<String, dynamic> info = await GetInfoAPI.getInfo();
      setState(() {
        info_ = info;
      });
    } catch (e) {
      print('API request error: $e');
    }
    // if (!context.mounted) return;
    // Navigator.of(context).pop();
  }

  void _onLoaded() {
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _info();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Text('+'),
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
                        image: info_["background"] != null
                            ? NetworkImage(
                                    "https://$host${info_['background']}")
                                as ImageProvider
                            : const AssetImage('assets/images/Background.png'),
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
                        backgroundImage: info_["photo"] != null
                            ? NetworkImage("https://$host${info_['photo']}")
                                as ImageProvider
                            : const AssetImage('assets/images/Avatar.png'),
                        backgroundColor: Colors.transparent),
                  ),
                  Positioned(
                    top: 124.5,
                    left: 154,
                    child: Text(
                      info_["name"] ?? "",
                      style: AppStyle.header(color: AppStyle.white),
                    ),
                  ),
                  Positioned(
                    top: 154.5,
                    left: 154,
                    child: CopyableText(
                      text_: info_["userID"] ?? "",
                    ),
                  ),
                ],
              ),
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
                    FriendsList(onLoaded: _onLoaded),
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
                        Navigator.popAndPushNamed(context, '/login');
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
