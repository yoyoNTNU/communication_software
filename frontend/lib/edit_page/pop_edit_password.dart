import 'package:flutter/material.dart';
import 'avatar_box.dart';
import 'package:proj/login/login_widget.dart';
import 'package:proj/edit_page/edit_profile.dart';
import 'package:proj/style.dart';

class popEditPassword extends StatefulWidget {
  const popEditPassword({super.key});

  @override
  State<popEditPassword> createState() => _popEditPasswordState();
}

class _popEditPasswordState extends State<popEditPassword> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            height: 400,
            width: 300,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 42,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Text(''), flex: 1),
                      Container(
                        child: const Text('修改密碼'),
                      ),
                      // const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Image.asset(
                              // Icons.close, // Use the correct icon from the Icons class
                              'assets/icons/Close_round.png',
                              width: 20, // Set the size as needed
                              height: 18,
                              color:
                                  AppStyle.blue[400], // Set the color as needed
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: AppTextField(
                    key: UniqueKey(),
                    controller: _oldPasswordController,
                    isPassword: true,
                    labelText: '驗證舊密碼',
                    hintText: '請輸入就密碼',
                    onTap: () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  child: AppTextField(
                    key: UniqueKey(),
                    controller: _newPasswordController,
                    isPassword: true,
                    labelText: '設定新密碼',
                    hintText: '請輸入新密碼',
                    onTap: () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                  ),
                ),
                Container(
                  child: AppTextField(
                    key: UniqueKey(),
                    controller: _confirmPassController,
                    isPassword: true,
                    labelText: '驗證新密碼',
                    hintText: '請輸入新密碼',
                    onTap: () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                Container(
                  height: 36,
                  child: popButtonIcon(Colors.white, '儲存修改'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget popButtonIcon(Color textColor, String text) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      backgroundColor: const Color(0xFF40A8C4),
    ),
    icon: const Icon(Icons.save),
    onPressed: () {},
    label: TextWithColorParameter(text, textColor),
  );
}
