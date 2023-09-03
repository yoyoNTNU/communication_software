import 'package:flutter/material.dart';
import './materials/navbar.dart';
import 'package:proj/login/login_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:proj/data.dart';
import 'package:http/http.dart' as http;

// Define http host name
const String host = 'express-message-development.onrender.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 WidgetsFlutterBinding 已初始化

  // 初始化数据库和获取令牌
  final token = await initDatabaseAndGetToken();

  // 验证令牌是否有效
  final isTokenValid = await verifyToken(token);

  runApp(ChatApp(isTokenValid: isTokenValid));
}

Future<String?> initDatabaseAndGetToken() async {
  // 初始化数据库
  databaseFactoryOrNull = null;
  databaseFactory = databaseFactoryFfi;
  sqfliteFfiInit();

  // 从数据库中获取令牌
  final token = await DatabaseHelper.instance.getToken();
  return token?.authorization;
}

Future<bool> verifyToken(String? token) async {
  if (token == null) {
    return false; // 令牌不存在，无效
  }

  // 调用 API 验证令牌
  final response = await http.get(
    Uri(scheme: 'https', host: host, path: '/api/member/info'),
    headers: {'Authorization': token},
  );

  if (response.statusCode == 200) {
    return true; // 令牌有效
  } else {
    return false; // 令牌无效
  }
}

class ChatApp extends StatelessWidget {
  final bool isTokenValid;

  const ChatApp({Key? key, required this.isTokenValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 根据令牌验证结果导航到不同的路径
    final initialRoute = isTokenValid ? '/home' : '/login';

    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const NavBar(),
      },
    );
  }
}
