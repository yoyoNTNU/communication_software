import 'package:proj/style.dart';
import 'package:flutter/material.dart';
import 'package:proj/sent_reset_email/widget/sent_reset_email_widget.dart';

class SentSuccess extends StatefulWidget {
  const SentSuccess({super.key});

  @override
  State<SentSuccess> createState() => _SentSuccessState();
}

class _SentSuccessState extends State<SentSuccess> {
  final ScrollController _scrollController = ScrollController();
  int confirmLetterState = 0;
  bool isResentButtonEnable = true;

  @override
  Widget build(BuildContext context) {
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
                          title: '驗證信已寄出',
                          content: Column(children: [
                            Image.asset(
                              'assets/images/success_logo.png',
                              height: 88,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '重新設定密碼信件已寄出，\n請至信箱確認並點擊連結以更新密碼',
                              style: AppStyle.info(
                                level: 2,
                                color: AppStyle.blue[700]!,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/login');
                              },
                              style: AppStyle.secondaryBtn(),
                              child: const Text("返回登入畫面"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ]),
                        ),
                        const SizedBox(height: 200),
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
}
