import 'package:proj/style.dart';
import 'package:flutter/material.dart';
import 'package:proj/sign_up/sign_up_widget.dart';
import 'package:proj/sign_up/sign_up_api.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

class LoginNotConfirm extends StatefulWidget {
  final String email;

  const LoginNotConfirm({required this.email, super.key});

  @override
  State<LoginNotConfirm> createState() => _LoginNotConfirmState();
}

class _LoginNotConfirmState extends State<LoginNotConfirm> {
  final ScrollController _scrollController = ScrollController();
  int confirmLetterState = 0;
  bool isResentButtonEnable = true;

  Future<void> _sentConfirmLetter(String email) async {
    try {
      final int sentState = await ConfirmLetterAPI.sentConfirmLetter(email);
      setState(() {
        confirmLetterState = sentState;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final CountdownTimerController controller = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 60000,
      onEnd: () {
        setState(() {
          isResentButtonEnable = true;
        });
      },
    );
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
                          title: '登入失敗 - 帳戶未驗證',
                          content: Column(children: [
                            Image.asset(
                              'assets/images/fail_logo.png',
                              height: 88,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '帳戶未完成開通，\n請至郵件收取開通驗證信',
                              style: AppStyle.info(
                                level: 2,
                                color: AppStyle.gray[500]!,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            OutlinedButton(
                              onPressed: isResentButtonEnable
                                  ? () {
                                      setState(() {
                                        isResentButtonEnable = false;
                                        controller.endTime = DateTime.now()
                                                .millisecondsSinceEpoch +
                                            60000;
                                      });

                                      _sentConfirmLetter(widget.email);
                                    }
                                  : null,
                              style: AppStyle.primaryBtn(
                                  backgroundColor: Colors.transparent,
                                  pressedColor: AppStyle.sea,
                                  textColor: AppStyle.teal),
                              child: isResentButtonEnable
                                  ? const Text("重寄驗證信")
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "重寄驗證信",
                                          style: AppStyle.caption(
                                              color: AppStyle.gray.shade100),
                                        ),
                                        CountdownTimer(
                                          controller: controller,
                                          widgetBuilder: (_, time) {
                                            if (time == null) {
                                              setState(() {
                                                isResentButtonEnable = true;
                                              });
                                              return Text(
                                                '0S',
                                                style: AppStyle.caption(
                                                  color: AppStyle.gray.shade100,
                                                ),
                                              );
                                            }
                                            return Text(
                                              ' ${time.sec}S',
                                              style: AppStyle.caption(
                                                  color:
                                                      AppStyle.gray.shade100),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  controller.dispose();
                                  isResentButtonEnable = true;
                                });
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
                        const SizedBox(height: 156),
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
