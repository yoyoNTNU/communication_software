import 'package:flutter/material.dart';
import 'account_box.dart';


class BasicBox1 extends StatefulWidget {
  const BasicBox1({super.key});

  @override
  State<BasicBox1> createState() => _BasicBox1State();
}

class _BasicBox1State extends State<BasicBox1> {
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
              child: unitHeader('個人資料'),
            ),
            divider(),
            Expanded(
              flex: 44,
              child: unitBox('使用者名稱', 'Exp. Message', '修改', context),
            ),
            Expanded(
              flex: 44,
              child: unitBox('個性簽名', '\\\\\\OwwwwO///', '修改', context),
            ),
            Expanded(
              flex: 44,
              child: unitBox('生日', '1900 年 5 月 1 日', '修改', context),
            ),
          ],
        ),
      ),
    );
  }
}
