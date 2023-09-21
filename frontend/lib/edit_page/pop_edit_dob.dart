import 'package:flutter/material.dart';
import 'avatar_box.dart';
import 'package:proj/login/login_widget.dart';
import 'package:proj/edit_page/edit_profile.dart';
import 'package:proj/style.dart';

class popEditDOB extends StatefulWidget {
  const popEditDOB({super.key});

  @override
  State<popEditDOB> createState() => _popEditDOBState();
}

class _popEditDOBState extends State<popEditDOB> {
  final TextEditingController dobController = TextEditingController();
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
            height: 200,
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
                        child: const Text('修改生日資訊'),
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
                  //height: 40,
                  child: AppTextField(
                    key: UniqueKey(),
                    controller: dobController,
                    labelText: '生日',
                    hintText: '請輸入生日',
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
