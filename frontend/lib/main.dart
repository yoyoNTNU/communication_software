import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proj/edit_page/edit_page_screen.dart';
import 'package:proj/sign_up/sign_up_screen.dart';
import 'package:proj/materials/navbar.dart';
import 'package:proj/login/login_screen.dart';
import 'package:proj/sent_reset_email/sent_reset_email_screen.dart';
import 'package:proj/group/group_screen.dart';
import 'package:proj/search/search_screen.dart';
import 'package:proj/materials/animated_screen.dart';
import 'package:proj/friend_invite/friend_invite_screen.dart';
import 'package:proj/chatroom/chatroom_screen.dart';
import 'package:media_kit/media_kit.dart';

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
  MediaKit.ensureInitialized();

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          toolbarHeight: 42,
        ),
      ),
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
      home: const AnimatedPage(),
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const NavBar(),
        '/sign_up': (context) => const SignUp(),
        '/forget_password': (context) => const SentResetEmail(),
        '/edit': (context) => const EditPage(),
        '/group': (context) => const GroupPage(),
        '/search': (context) => const SearchPage(),
        '/invite': (context) => const FriendInvite(),
        '/chatroom': (context) => const ChatroomPage()
      },
    );
  }
}
