import 'package:express_message/style.dart';
import 'package:express_message/login/login_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
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
                  title: "使用者登入",
                  content: Column(
                    children: [
                      AppTextField(
                          key: UniqueKey(),
                          controller: _accountController,
                          labelText: '帳號（電子信箱）',
                          hintText: '請輸入帳號',
                          errorText: null),
                      const SizedBox(height: 16),
                      AppTextField(
                          key: UniqueKey(),
                          controller: _passwordController,
                          labelText: '密碼',
                          hintText: '請輸入密碼',
                          errorText: null,
                          isPassword: true),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Buttons
                          ElevatedButton(
                            onPressed: null,
                            style: AppStyle.primaryBtn(),
                            child: const Text("登入"),
                          ),
                          const SizedBox(width: 16),
                          // Outline Button
                          OutlinedButton(
                            onPressed: null,
                            style: AppStyle.primaryBtn(),
                            child: const Text("忘記密碼"),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 32),
              const ElevatedButton(
                onPressed: null,
                child: Text("註冊"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
