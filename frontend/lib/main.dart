import 'package:flutter/material.dart';
import './materials/navbar.dart';

void main() => runApp(const ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavBar());
  }
}
