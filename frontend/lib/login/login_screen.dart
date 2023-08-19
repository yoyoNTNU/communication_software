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
      color: const Color(0xFFE6F0F5),
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
          const Text(
            'Instant Communication, Delivered Express',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF195374),
              fontSize: 16,
              fontFamily: 'Noto Sans TC',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.40,
            ),
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
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
