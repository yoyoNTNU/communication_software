import 'package:proj/style.dart';
import 'package:proj/sent_reset_email/widget/sent_reset_email_widget.dart';
import 'package:proj/sent_reset_email/sent_reset_email_api.dart';
import 'package:proj/sent_reset_email/sent_reset_email_success.dart';
import 'package:flutter/material.dart';

class SentResetEmail extends StatefulWidget {
  const SentResetEmail({super.key});

  @override
  State<SentResetEmail> createState() => _SentResetEmailState();
}

class _SentResetEmailState extends State<SentResetEmail> {
  final ScrollController _scrollController = ScrollController();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  int responseCode = 200;

  int step_ = 1;

  Future<void> _sentResetEmail(String email) async {
    try {
      final int code = await ResetEmailAPI.sentResetEmail(email);
      if (!mounted) return;
      setState(() {
        responseCode = code;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  void _sentSuccessOrFail() {
    if (responseCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SentSuccess()),
      );
    } else {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                      needLeftButton: true,
                      title: "忘記密碼",
                      onClicked: () {
                        setState(() {
                          step_ = step_ - 1;
                          if (step_ == 0) {
                            Navigator.popAndPushNamed(context, '/login');
                          }
                        });
                      },
                      content: Column(
                        children: [
                          AppTextField(
                            key: UniqueKey(),
                            controller: _emailController,
                            labelText: '電子信箱',
                            hintText: '請輸入信箱',
                            errorText: responseCode == 200 ? null : "錯誤",
                            isRequired: true,
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              });
                            },
                            onChanged: (value) {
                              if (responseCode != 200) {
                                if (!mounted) return;
                                setState(() {
                                  responseCode = 200;
                                });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _sentResetEmail(
                                        _emailController.text);
                                    _sentSuccessOrFail();
                                  },
                            style: AppStyle.primaryBtn(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _isLoading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppStyle.white,
                                        ))
                                    : SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(
                                            "assets/icons/mail_white.png"),
                                      ),
                                const SizedBox(width: 8),
                                const Text("寄出驗證信"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 261),
                    Text(
                      "Instant Communication, Delivered Express",
                      style:
                          AppStyle.info(level: 2, color: AppStyle.blue[700]!),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
