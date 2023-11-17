import 'package:flutter/material.dart';
import 'package:proj/app_setting/app_setting_api.dart';
import 'package:proj/style.dart';
import 'package:proj/app_setting/pop_widget/drop_down.dart';
import 'package:proj/app_setting/success_screen.dart';

class PopProbFB extends StatefulWidget {
  const PopProbFB({super.key});

  @override
  State<PopProbFB> createState() => _PopProbFBState();
}

class _PopProbFBState extends State<PopProbFB> {
  final ScrollController _scrollController = ScrollController();
  final _txtController = TextEditingController();
  final _editController = TextEditingController();
  int? _selectedOption = 0;
  String? fixType = "email";
  bool _isLoading = false;
  int _responseCode = 400;

  Future<void> _sentIssue(
      {String? type,
      String? content}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await AppSettingAPI.issue(
          type: type,
          content: content);
      setState(() {
        _responseCode = responseCode;
      });
    } catch (e) {
      print('API request error: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: 480,
            height: 545,
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        child: Text(
                          '問題 / 反饋',
                          style: AppStyle.header(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset("assets/icons/X_blue.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 500,
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '問題類型',
                        style: AppStyle.body(color: AppStyle.blue[500]!),
                      ),
                      ..._buildRadioOptions(),
                      const SizedBox(height: 24.0),
                      if (_selectedOption != 4) ...[
                          Text(
                            '問題描述',
                            style: AppStyle.body(color: AppStyle.blue[500]!),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _txtController,
                              textAlign: TextAlign.start,
                              expands: false,
                              maxLines: 10, // This makes it expandable
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppStyle.blue[500]!),
                                  borderRadius: BorderRadius.circular(5),
                              ),
                              ),
                            ),
                          ),
                      ],
                      if (_selectedOption == 4) ...[
                        Text(
                          '修改項目',
                          style: AppStyle.body(color: AppStyle.blue[500]!),
                        ),
                        Dropdown(
                          onChanged: (value) {
                            if (fixType != value) {
                              setState(() {
                                fixType = value;
                              });
                            }
                          },
                          type: fixType
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          '修改內容',
                          style: AppStyle.body(color: AppStyle.blue[500]!),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _editController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppStyle.blue[500]!),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        // AppTextField(
                        //   key: UniqueKey(),
                        //   controller: _fixController,
                        //   isPassword: false,
                        //   labelText: '修改內容',
                        //   hintText: '請輸入新的修改資料',
                        //   onTap: () {
                        //     _scrollController.animateTo(
                        //         _scrollController.position.maxScrollExtent,
                        //         duration: const Duration(milliseconds: 300),
                        //         curve: Curves.easeInOut);
                        //   },
                        // ),
                      ],
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    _selectedOption == 1 ? await _sentIssue(
                                      type: "使用操作疑問", content: _txtController.text) :
                                    _selectedOption == 2 ? await _sentIssue(
                                      type: "程式錯誤、功能故障無法排解", content: _txtController.text) :
                                    _selectedOption == 3 ? await _sentIssue(
                                      type: "意見反饋", content: _txtController.text) :
                                    await _sentIssue(type: "資料修改申請", content: _editController.text);
                                    if (_responseCode == 200) {
                                      if (!context.mounted) return;
                                      // _selectedOption != 4 ? Navigator.of(context).pop(_txtController.text) :
                                      //     Navigator.of(context).pop(_editController.text); // option = 4
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => SentSuccess(type: _selectedOption),
                                      );
                                    } else {
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                      // showFail(context, "發生非預期錯誤，請回報相關人員");
                                    }
                                  },
                            style: AppStyle.primaryBtn(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '問題類型',
                                  style:
                                      AppStyle.body(color: AppStyle.blue[500]!),
                                ),
                                ..._buildRadioOptions(),
                                const SizedBox(height: 24.0),
                                if (_selectedOption != 4) ...[
                                  Text(
                                    '問題描述',
                                    style: AppStyle.body(
                                        color: AppStyle.blue[500]!),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.start,
                                      expands: false,
                                      maxLines: 10, // This makes it expandable
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppStyle.blue[500]!),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (_selectedOption == 4) ...[
                                  Text(
                                    '修改項目',
                                    style: AppStyle.body(
                                        color: AppStyle.blue[500]!),
                                  ),
                                  Dropdown(
                                      onChanged: (value) {
                                        if (fixType != value) {
                                          setState(() {
                                            fixType = value;
                                          });
                                        }
                                      },
                                      type: fixType),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    '修改內容',
                                    style: AppStyle.body(
                                        color: AppStyle.blue[500]!),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppStyle.blue[500]!),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // AppTextField(
                                  //   key: UniqueKey(),
                                  //   controller: _fixController,
                                  //   isPassword: false,
                                  //   labelText: '修改內容',
                                  //   hintText: '請輸入新的修改資料',
                                  //   onTap: () {
                                  //     _scrollController.animateTo(
                                  //         _scrollController.position.maxScrollExtent,
                                  //         duration: const Duration(milliseconds: 300),
                                  //         curve: Curves.easeInOut);
                                  //   },
                                  // ),
                                ],
                                const SizedBox(height: 24.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => SentSuccess(
                                              type: _selectedOption),
                                        );
                                      },
                                      style: AppStyle.primaryBtn(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("送出"),
                                          const SizedBox(width: 8),
                                          _isLoading
                                              ? const SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: AppStyle.white,
                                                  ))
                                              : SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: Image.asset(
                                                      "assets/icons/send_white.png"),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
      )    
    );
  }

  List<Widget> _buildRadioOptions() {
    return [
      _radioOption('使用操作問題', 1),
      _radioOption('程式錯誤、功能無法順利執行', 2),
      _radioOption('建議反饋', 3),
      _radioOption('資料修改申請', 4),
    ];
  }

  Widget _radioOption(String title, int value) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 16.0),
      title: Text(
        title,
        style: AppStyle.body(color: AppStyle.gray[700]!), // Your existing style
      ),
      leading: Radio(
        value: value,
        activeColor: AppStyle.teal,
        groupValue: _selectedOption,
        onChanged: (int? newValue) {
          setState(() {
            _selectedOption = newValue;
          });
        },
      ),
    );
  }
}
