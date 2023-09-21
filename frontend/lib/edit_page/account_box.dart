import 'package:flutter/material.dart';
import 'package:proj/edit_page/pop_edit_dob.dart';
import 'package:proj/edit_page/pop_edit_sign.dart';
import 'package:proj/edit_page/pop_edit_username.dart';
import 'pop_edit_password.dart';

class AccountBox extends StatefulWidget {
  const AccountBox({super.key});

  @override
  State<AccountBox> createState() => _AccountBoxState();
}

class _AccountBoxState extends State<AccountBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 27,
              child: unitHeader('帳戶資料'),
            ),
            divider(),
            Expanded(
              flex: 44,
              child: unitBox('用戶密碼', '***********', '修改', context),
            ),
            Expanded(
              flex: 44,
              child: unitBox('用戶 ID', 'EXP-MSG', '', context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget unitBox(String text1, String text2, String text3, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            text1,
            style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 14,
              fontFamily: 'Noto Sans TC',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.12,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            text2,
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 14,
              fontFamily: 'Noto Sans TC',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.56,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              if (text3 == '修改') {
                if (text1 == '用戶密碼') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const popEditPassword();
                    },
                  );
                } else if (text1 == '使用者名稱') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const popEditUsername();
                    },
                  );
                } else if (text1 == '個性簽名') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const popEditSign();
                    },
                  );
                } else if (text1 == '生日') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const popEditDOB();
                    },
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF40A8C4),
              backgroundColor: Colors.white,
            ),
            child: Text(text3),
          ),
        ),
      ],
    ),
  );
}

Widget unitHeader(String text1) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF707070),
            fontSize: 16,
            fontFamily: 'Noto Sans TC',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.28,
          ),
        ),
      ],
    ),
  );
}

Widget divider() {
  return Container(
    height: 1,
    decoration: BoxDecoration(color: Color(0xFFEBEBEB)),
  );
}
