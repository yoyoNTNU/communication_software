import 'package:flutter/material.dart';
import 'package:proj/edit_page/edit_page_api.dart';
import 'package:proj/edit_page/edit_page_widget.dart';
import 'package:proj/style.dart';
import 'package:proj/widget.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic> info_ = {};

  Future<void> _info() async {
    showLoading(context);
    try {
      final Map<String, dynamic> info = await GetDetailAPI.getInfo();
      setState(() {
        info_ = info;
      });
    } catch (e) {
      print('API request error: $e');
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _info();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.blue[50],
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.popAndPushNamed(context, '/home'),
              child: Image.asset("assets/icons/left.png")),
          title: Text(
            '編輯個人資料',
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
                    accountBox(context, info_['userID']),
                    const SizedBox(height: 24.0),
                    infoBox(context, info_['birthday'], info_['name'],
                        info_['intro']),
                    const SizedBox(height: 24.0),
                    communityBox(info_['email'], info_['phone']),
                    const SizedBox(height: 24.0),
                    AvatarBox(
                      avatar: info_['photo'],
                    ),
                    const SizedBox(height: 24.0),
                    const BackgroundBox(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
