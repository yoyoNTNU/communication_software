import 'package:proj/style.dart';
import 'package:proj/sign_up/sign_up_widget.dart';
import 'package:proj/sign_up/sign_up_api.dart';
import 'package:proj/sign_up/sign_up_success.dart';
import 'package:proj/sign_up/sign_up_fail.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ScrollController _scrollController = ScrollController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationController = TextEditingController();
  final _nameController = TextEditingController();
  final _useridController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic> message = {};

  int step_ = 1;

  Future<void> _signUp(String email, String phone, String userID, String name,
      String password, String confirm) async {
    try {
      final Map<String, dynamic> signUp =
          await SignUpAPI.signUp(email, phone, userID, name, password, confirm);
      setState(() {
        message = signUp;
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  void _signUpSuccessOrFail() {
    if (message['state'] == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpSuccess(email: _emailController.text)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpFail(errorMessage: message)),
      );
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
                      title: title_(step_),
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
                          if (step_ == 1)
                            AppTextField(
                              key: UniqueKey(),
                              controller: _emailController,
                              labelText: '電子信箱',
                              hintText: '請輸入信箱',
                              isRequired: true,
                              additionText: '請輸入有效之電子信箱帳號以進行驗證開通',
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                });
                              },
                              onChanged: (value) {},
                            ),
                          if (step_ == 2)
                            AppTextField(
                              key: UniqueKey(),
                              controller: _nameController,
                              labelText: '使用者名稱',
                              hintText: '請輸入使用者名稱',
                              isRequired: true,
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                });
                              },
                              onChanged: (value) {},
                            ),
                          if (step_ == 3)
                            AppTextField(
                              key: UniqueKey(),
                              controller: _passwordController,
                              labelText: '設定密碼',
                              hintText: '請輸入密碼',
                              isRequired: true,
                              isPassword: true,
                              additionText: '請輸入 6-24 位英數組合之密碼（需含大小寫）',
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                });
                              },
                              onChanged: (value) {},
                            ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (step_ == 1)
                            AppTextField(
                              key: UniqueKey(),
                              controller: _phoneController,
                              controller2: _nationController,
                              labelText: '手機號碼',
                              hintText: '請輸入手機號碼(最前面的0不用輸入)',
                              isRequired: true,
                              isPhone: true,
                              onTap: () {
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                );
                              },
                              onChanged: (value) {},
                            ),
                          if (step_ == 2)
                            AppTextField(
                              key: UniqueKey(),
                              controller: _useridController,
                              labelText: '用戶ID設定',
                              hintText: '請輸入用戶ID',
                              isRequired: true,
                              additionText: '設定一組讓朋友能更快找到你的專屬 ID',
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                });
                              },
                              onChanged: (value) {},
                            ),
                          if (step_ == 3)
                            AppTextField(
                              key: UniqueKey(),
                              controller: _confirmController,
                              labelText: '確認密碼',
                              hintText: '請再次輸入密碼',
                              isRequired: true,
                              isPassword: true,
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                });
                              },
                              onChanged: (value) {},
                            ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (step_ == 1 || step_ == 2)
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  step_++;
                                });
                              },
                              style: AppStyle.secondaryBtn(),
                              child: const Text("下一步"),
                            ),
                          if (step_ == 3)
                            ElevatedButton(
                              onPressed: !_isLoading
                                  ? () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await _signUp(
                                          _emailController.text,
                                          _phoneController.text != ""
                                              ? _nationController.text +
                                                  _phoneController.text
                                              : "",
                                          _useridController.text,
                                          _nameController.text,
                                          _passwordController.text,
                                          _confirmController.text);
                                      _signUpSuccessOrFail();
                                    }
                                  : null,
                              style: AppStyle.primaryBtn(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_isLoading)
                                    const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppStyle.white,
                                      ),
                                    ),
                                  if (_isLoading) const SizedBox(width: 8),
                                  const Text("送出"),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 4,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: AppStyle.info(
                                      level: 3, color: AppStyle.red),
                                ),
                                TextSpan(
                                  text: '字欄位為必填項目',
                                  style: AppStyle.info(
                                      level: 2, color: AppStyle.gray[500]!),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 146),
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

String title_(int step_) {
  switch (step_) {
    case 1:
      return "註冊帳號";
    case 2:
      return "註冊帳號 - 用戶資料";
    case 3:
      return "註冊帳號 - 密碼設定";
  }
  return "error";
}
