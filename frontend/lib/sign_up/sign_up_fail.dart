import 'package:proj/style.dart';
import 'package:flutter/material.dart';
import 'package:proj/sign_up/sign_up_widget.dart';

class SignUpFail extends StatefulWidget {
  final Map<String, dynamic> errorMessage;

  const SignUpFail({required this.errorMessage, super.key});

  @override
  State<SignUpFail> createState() => _SignUpFailState();
}

class _SignUpFailState extends State<SignUpFail> {
  final ScrollController _scrollController = ScrollController();
  final List<String> mainType = ['使用者資訊', '電子信箱', '密碼', '手機號碼'];
  final List<String> mainIcon = [
    'assets/icons/user.png',
    'assets/icons/mail.png',
    'assets/icons/key.png',
    'assets/icons/phone.png',
  ];
  List<List<String>> secType = List.generate(4, (index) => []);
  List<List<bool>> isPass = List.generate(4, (index) => []);
  void parseErrorMessage() {
    if (widget.errorMessage['name'] == null) {
      secType[0].add('名稱可使用');
      isPass[0].add(true);
    } else {
      secType[0].add('名稱不可為空');
      isPass[0].add(false);
    }

    if (widget.errorMessage['userID'] == null) {
      secType[0].add('ID可使用');
      isPass[0].add(true);
    } else {
      List<dynamic> tempDynamic =
          widget.errorMessage['userID'] as List<dynamic>;
      List<String> temp =
          tempDynamic.map((element) => element.toString()).toList();
      if (temp[0] == "can't be blank") {
        secType[0].add('ID不可為空');
        isPass[0].add(false);
      } else {
        secType[0].add('ID已被使用');
        isPass[0].add(false);
      }
    }

    if (widget.errorMessage['email'] == null) {
      secType[1].add('信箱可使用');
      isPass[1].add(true);
    } else {
      List<dynamic> tempDynamic = widget.errorMessage['email'] as List<dynamic>;
      List<String> temp =
          tempDynamic.map((element) => element.toString()).toList();
      if (temp[0] == "can't be blank") {
        secType[1].add('不可為空');
        isPass[1].add(false);
      } else if (temp[0] == "is not an email") {
        secType[1].add('錯誤的信箱');
        isPass[1].add(false);
      } else {
        secType[1].add('已被使用');
        isPass[1].add(false);
      }
    }

    if (widget.errorMessage['phone'] == null) {
      secType[3].add('手機號碼可使用');
      isPass[3].add(true);
    } else {
      List<dynamic> tempDynamic = widget.errorMessage['phone'] as List<dynamic>;
      List<String> temp =
          tempDynamic.map((element) => element.toString()).toList();
      if (temp[0] == "can't be blank") {
        secType[3].add('不可為空');
        isPass[3].add(false);
      } else {
        secType[3].add('已被使用');
        isPass[3].add(false);
      }
    }

    if (widget.errorMessage['password'] == null &&
        widget.errorMessage['password_confirmation'] == null) {
      secType[2].add('密碼可使用');
      isPass[2].add(true);
    } else {
      if (widget.errorMessage['password'] != null) {
        List<dynamic> tempDynamic =
            widget.errorMessage['password'] as List<dynamic>;
        List<String> temp =
            tempDynamic.map((element) => element.toString()).toList();
        if (temp[0] == "can't be blank") {
          secType[2].add('不可為空');
          isPass[2].add(false);
        } else {
          secType[2].add('6~24位 含大小寫英數');
          isPass[2].add(false);
        }
      }
      if (widget.errorMessage['password_confirmation'] != null) {
        secType[2].add('兩次輸入密碼不一致');
        isPass[2].add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    parseErrorMessage();
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              height: double.infinity,
              color: AppStyle.blue[50],
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  color: AppStyle.blue[50],
                  padding: const EdgeInsets.only(
                    top: 44,
                    left: 24,
                    right: 24,
                    bottom: 34,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const AppLogo(),
                        AppBox(
                          needLeftButton: false,
                          title: '註冊失敗',
                          content: Column(children: [
                            Text(
                              '請符合以下所有條件以完成註冊',
                              style: AppStyle.caption(color: AppStyle.gray),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ErrorShow(
                                mainType: mainType,
                                mainIcon: mainIcon,
                                secType: secType,
                                isPass: isPass),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/sign_up');
                              },
                              style: AppStyle.primaryBtn(
                                  backgroundColor: Colors.transparent,
                                  pressedColor: AppStyle.sea,
                                  textColor: AppStyle.teal),
                              child: const Text("重新註冊"),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/login');
                              },
                              style: AppStyle.primaryBtn(
                                  backgroundColor: Colors.transparent,
                                  pressedColor: AppStyle.sea,
                                  textColor: AppStyle.teal),
                              child: const Text("返回登入畫面"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ]),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "Instant Communication, Delivered Express",
                          style: AppStyle.info(
                              level: 2, color: AppStyle.blue[700]!),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
