import 'package:proj/style.dart';
import 'package:flutter/material.dart';
import 'package:proj/app_setting/widget/app_setting_widget.dart';

class SentSuccess extends StatefulWidget {
  final int? type;
  const SentSuccess({
    super.key,
    required this.type,
  });

  @override
  State<SentSuccess> createState() => _SentSuccessState();
}

class _SentSuccessState extends State<SentSuccess> {
  final ScrollController _scrollController = ScrollController();
  int confirmLetterState = 0;
  bool isResentButtonEnable = true;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              height: double.infinity,
              color: AppStyle.blue[50],
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  color: AppStyle.blue[50],
                  padding: const EdgeInsets.only(
                    top: 44,
                    left: 24,
                    right: 24,
                    bottom: 34,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const AppLogo(),
                        AppBox(
                          // needLeftButton: false,
                          title: '感謝您的回報',
                          content: Column(children: [
                            Image.asset(
                              'assets/images/success_logo.png',
                              height: 88,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                               (widget.type == 1 || widget.type == 2) ?
                                '我們已收到您的問題\n問題將由專員儘速為您服務與處理，\n'
                                '煩請等待後續 Email 通知回覆問題處理狀況\n感謝您的耐心等候':
                              (widget.type == 3) ? 
                                '我們已收到您的意見\n您的寶貴意見將會傳遞給開發團隊，\n'
                                '列入下次版本更新的考量\n感謝您對本軟體的支持與反饋！' :
                              (widget.type == 4) ? 
                                '我們已收到您的修改申請\n我們將後續進行您的申請審核與修改作業，\n'
                                '請靜候等待 Email 通知審核與修改結果' : 
                                "erroooooooor", 
                              style: AppStyle.info(
                                level: 2,
                                color: AppStyle.blue[700]!,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/setting');
                              },
                              style: AppStyle.secondaryBtn(),
                              child: const Text("返回登入畫面"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ]),
                        ),
                        const SizedBox(height: 200),
                        Text(
                          "Instant Communication, Delivered Express",
                          style: AppStyle.info(
                              level: 2, color: AppStyle.blue[700]!),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
  // void _sentSuccessOrFail() {
  //   if (responseCode == 200) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const SentSuccess()),
  //     );
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
}
