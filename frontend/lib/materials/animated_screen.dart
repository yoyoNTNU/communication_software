import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/materials/animated_dependency.dart';

class AnimatedPage extends StatelessWidget {
  const AnimatedPage({
    super.key,
  });

  void init(BuildContext context) async {
    final token = await initDatabaseAndGetToken();
    final isTokenValid = await verifyToken(token);
    final initialRoute = isTokenValid ? '/home' : '/login';
    await initCache();
    if (!context.mounted) return;
    Navigator.popAndPushNamed(context, initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    return Container(
      color: AppStyle.blue[50],
      child: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
