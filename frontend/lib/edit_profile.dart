import 'package:flutter/material.dart';
import 'account_box.dart';
import 'basic_box1.dart';
import 'basic_box2.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F0F5),
      appBar: AppBar(
        title: Text(
          '編輯個人資料',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 18,
            fontFamily: 'Noto Sans TC',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.44,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 172,
              child: AccountBox(),
            ),
            SizedBox(height: 24.0),
            Expanded(
              flex: 224,
              child: BasicBox1(),
            ),
            SizedBox(height: 24.0),
            Expanded(
              flex: 184,
              child: BasicBox2(),
            ),
          ],
        ),
      ),
    );
  }
}
