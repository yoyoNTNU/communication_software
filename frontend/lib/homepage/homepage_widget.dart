import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj/style.dart';

class CopyableText extends StatelessWidget {
  const CopyableText({
    super.key,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: "EXP-MSG")); //換成API
    const snackBar = SnackBar(
      content: Text('已將ID複製到剪貼板'),
      duration: Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _copyToClipboard(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.blue[50],
            borderRadius: BorderRadius.circular(4), // 將所有角變成圓角
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            children: [
              Text(
                '# ',
                style: AppStyle.info(color: AppStyle.blue[300]!),
              ),
              Text(
                'EXP-MSG',
                style: AppStyle.info(color: AppStyle.blue[300]!),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 13,
                height: 13,
                child: Image.asset("assets/icons/Copy.png"),
              )
            ],
          ),
        ));
  }
}
