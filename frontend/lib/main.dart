import 'package:flutter/material.dart';
import './materials/navbar.dart';
import 'package:proj/login/login_screen.dart';

// Define http host name
const String host = 'express-message-development.onrender.com';

void main() => runApp(const ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const NavBar(),
      },
    );
  }
}
