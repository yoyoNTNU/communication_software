import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/homepage/widget/homepage_widget.dart';
import 'package:proj/homepage/homepage_api.dart';
import 'package:proj/widget.dart';
import 'package:proj/data.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? info_ = {};
  bool isExpanded = false;
  Completer<void> dialogShower = Completer<void>();
  Completer<void> dialogCompleter = Completer<void>();
  int? index;

  Future<void> _info() async {
    index = await DatabaseHelper.instance.getHomepageIndex();
    if (index == 1) return;
    info_ = await DatabaseHelper.instance.getCachedSelfData();
    if (!dialogCompleter.isCompleted) {
      if (!context.mounted) return;
      showLoading(context);
      dialogShower.complete();
    }
    if (info_ == null) {
      //print("API");
      try {
        final Map<String, dynamic> info = await GetInfoAPI.getInfo();
        if (mounted) {
          setState(() {
            info_ = info;
          });
          await DatabaseHelper.instance.cacheSelfData(info_!);
          _startTimer();
        }
      } catch (e) {
        print('API request error: $e');
      }
    } else {
      //print("Cache");
    }
    if (mounted) {
      setState(() {});
    }

    //if (!context.mounted) return;
    //Navigator.of(context).pop();
  }

  void _onLoaded() {
    if (dialogShower.isCompleted) {
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }
    dialogCompleter.complete();
  }

  @override
  void initState() {
    super.initState();
    _info();
  }

  void _startTimer() {
    const Duration duration = Duration(minutes: 5);
    Timer(duration, () {
      print("timeout");
      DatabaseHelper.instance.clearCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    return index == 0 || index == null
        ? RefreshIndicator(
            onRefresh: () async {
              await DatabaseHelper.instance.clearCache();
              if (!context.mounted) return;
              Navigator.popAndPushNamed(context, '/home');
            },
            child: Scaffold(
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
                          heroTag: "tag_1",
                          backgroundColor: AppStyle.yellow,
                          onPressed: () {
                            setState(() {
                              Navigator.popAndPushNamed(context, '/search');
                              isExpanded = false;
                            });
                          },
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child:
                                Image.asset("assets/icons/user_add_white.png"),
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
                          heroTag: "tag_2",
                          backgroundColor: AppStyle.teal,
                          onPressed: () {
                            setState(() {
                              Navigator.popAndPushNamed(context, '/group');
                              isExpanded = false;
                            });
                          },
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset("assets/icons/group_add.png"),
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
                          heroTag: "tag_3",
                          backgroundColor: AppStyle.blue[200]!,
                          onPressed: () {
                            setState(() {
                              isExpanded = false;
                            });
                          },
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset("assets/icons/x.png"),
                          ),
                        ),
                      ],
                    ),
                  if (!isExpanded)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          heroTag: "tag_4",
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
                              image: info_!["background"] != null
                                  ? NetworkImage(info_!["background"])
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/images/background.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0.40,
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration:
                                const BoxDecoration(color: Colors.white),
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
                              backgroundImage: info_!["photo"] != null
                                  ? NetworkImage(info_!["photo"])
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/images/avatar.png'),
                              backgroundColor: Colors.transparent),
                        ),
                        Positioned(
                          top: 124.5,
                          left: 154,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 164,
                            child: Text(
                              info_!["name"] ?? "",
                              style: AppStyle.header(color: AppStyle.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showProfileDialog(context);
                          },
                          child: Container(
                              width: double.infinity,
                              height: 210,
                              color: Colors.transparent),
                        ),
                        Positioned(
                          top: 154.5,
                          left: 154,
                          child: CopyableText(
                            text_: info_!["userID"] ?? "",
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 6,
                          child: GestureDetector(
                              onTap: () async {
                                await DatabaseHelper.instance.clearCache();
                                if (!context.mounted) return;
                                Navigator.popAndPushNamed(context, '/home');
                              },
                              child: Image.asset("assets/icons/refresh.png")),
                        )
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
              ),
            ),
          )
        : Container(
            color: AppStyle.blue[50],
          );
  }
}
