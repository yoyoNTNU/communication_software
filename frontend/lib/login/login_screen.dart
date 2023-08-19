import 'package:express_message/style.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.blue[50],
      padding: const EdgeInsets.only(
        top: 44,
        left: 24,
        right: 24,
        bottom: 34,
      ),
      child: const Center(
        child: Column(
          children: [
            Logo(),
            DialogBox(title: "使用者登入", content: Text("Hello")),
            ElevatedButton(
              onPressed: null,
              child: Text("註冊"),
            )
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Logo.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 8),
          Text(
            'Express Message',
            textAlign: TextAlign.center,
            style: AppStyle.header(level: 1, color: AppStyle.blue),
          ),
        ],
      ),
    );
  }
}

class DialogBox extends StatelessWidget {
  final String title;
  final Widget content;
  const DialogBox({super.key, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: AppStyle.black.withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: AppStyle.header(level: 2)),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
