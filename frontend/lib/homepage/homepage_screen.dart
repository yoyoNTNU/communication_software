import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/homepage/homepage_widget.dart';
import 'package:proj/homepage/homepage_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> info_ = {};
  bool isExpanded = false;

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
    if (!context.mounted) return;
    //Navigator.of(context).pop();
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 56 : 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "新增好友",
                    style: AppStyle.caption(),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  FloatingActionButton(
                    backgroundColor: AppStyle.yellow,
                    onPressed: () {
                      setState(() {
                        //TODO: push to search friend page
                        isExpanded = false;
                      });
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset("assets/icons/User_add_white.png"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 56 : 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "建立群組",
                    style: AppStyle.caption(),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  FloatingActionButton(
                    backgroundColor: AppStyle.teal,
                    onPressed: () {
                      setState(() {
                        //TODO: push to create group page
                        isExpanded = false;
                      });
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset("assets/icons/Group_add.png"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "取消",
                    style: AppStyle.caption(),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  FloatingActionButton(
                    backgroundColor: AppStyle.blue[200]!,
                    onPressed: () {
                      setState(() {
                        isExpanded = false;
                      });
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset("assets/icons/X.png"),
                    ),
                  ),
                ],
              ),
            if (!isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: AppStyle.blue,
                    onPressed: () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset("assets/icons/+.png"),
                    ),
                  ),
                ],
              ),
          ],
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
                            ? NetworkImage(info_["background"]) as ImageProvider
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
                    top: 90,
                    left: 12,
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: info_["photo"] != null
                            ? NetworkImage(info_["photo"]) as ImageProvider
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
                  top: 6,
                  bottom: 280,
                  left: 16,
                  right: 16,
                ),
                color: AppStyle.blue[50],
                child: Column(
                  children: [
                    const PrimeSelect(),
                    const SizedBox(
                      height: 24,
                    ),
                    const FriendsList(),
                    const SizedBox(
                      height: 24,
                    ),
                    GroupsList(onLoaded: _onLoaded),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}