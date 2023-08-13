import 'package:flutter/material.dart';
import 'account_box.dart';


class BasicBox2 extends StatefulWidget {
  const BasicBox2({super.key});

  @override
  State<BasicBox2> createState() => _BasicBox2State();
}

class _BasicBox2State extends State<BasicBox2> {
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
              child: unitHeader('通訊資料'),
            ),
            divider(),
            Expanded(
              flex: 44,
              child: unitBox('電子郵件', 'flyingdollar.cheng@gmail.com', ''),
            ),
            Expanded(
              flex: 44,
              child: unitBox('手機號碼', '0912345678', ''),
            ),
          ],
        ),
      ),
    );
  }
}
