import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proj/edit_page/edit_page_screen.dart';
import 'package:proj/sign_up/sign_up_screen.dart';
import 'package:proj/materials/navbar.dart';
import 'package:proj/login/login_screen.dart';
import 'package:proj/sent_reset_email/sent_reset_email_screen.dart';
import 'package:proj/main_dependency.dart';

// Define http host name
//backend develop server
const String host = 'express-message-development.onrender.com';
//backend product server
//const String host = 'express-message-production-wp18.onrender.com';
//develop google cloud image host
const String imgPath =
    'https://storage.googleapis.com/express_message_uploader/uploads';
//product google cloud image host
//const String imgPath ='https://storage.googleapis.com/express_message_production_uploader/uploads';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await initDatabaseAndGetToken();

  final isTokenValid = await verifyToken(token);

  runApp(ChatApp(isTokenValid: isTokenValid));
}

class ChatApp extends StatelessWidget {
  final bool isTokenValid;

  const ChatApp({Key? key, required this.isTokenValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialRoute = isTokenValid ? '/home' : '/login';

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'TW'),
        Locale('en', 'US'),
      ],
      locale: const Locale('zh'),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const NavBar(),
        '/sign_up': (context) => const SignUp(),
        '/forget_password': (context) => const SentResetEmail(),
        '/edit': (context) => const EditPage(),
      },
    );
  }
}
