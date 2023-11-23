import 'package:flutter/material.dart';
import 'package:proj/app_setting/widget/app_setting_widget.dart';
import 'package:proj/style.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});
  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.blue[50],
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.popAndPushNamed(context, '/home'),
              child: Image.asset("assets/icons/left.png")),
          title: Text(
            '應用設定',
            style: AppStyle.header(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    regardingUS(),
                    const SizedBox(height: 24.0),
                    versionInfo(),
                    const SizedBox(height: 24.0),
                    const LoginNotification(),
                    const SizedBox(height: 24.0),
                    reportProblem(context),
                    const SizedBox(height: 24.0),
                    const LogOutBtn(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
