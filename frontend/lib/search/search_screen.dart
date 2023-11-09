import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/search/widget/search_widget.dart';
import 'package:proj/search/search_api.dart';
import 'package:proj/profile_dialog/profile_dialog_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isChecked = true;
  final _iDController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationController = TextEditingController();
  final _isoCodeController = TextEditingController();
  int? friendID = 0;

  Future<void> _searchByPhone(String phone) async {
    try {
      final Map<String, dynamic> searcher = await SearchAPI.byPhone(phone);
      if (!mounted) return;
      setState(() {
        friendID = searcher['id'];
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  Future<void> _searchByUserID(String userID) async {
    try {
      final Map<String, dynamic> searcher = await SearchAPI.byUserID(userID);
      if (!mounted) return;
      setState(() {
        friendID = searcher['id'];
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  void initState() {
    _isoCodeController.text = "TW";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.blue[50],
      appBar: AppBar(
        leadingWidth: 48,
        titleSpacing: 0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.popAndPushNamed(context, '/home'),
            child: Image.asset("assets/icons/left.png"),
          ),
        ),
        title: Text(
          '新增好友',
          style: AppStyle.header(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: 112,
            width: double.infinity,
            color: AppStyle.white,
            child: Column(
              children: [
                Switcher(
                  onChanged: (value) {
                    setState(() {
                      friendID = 0;
                      _isChecked = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _isChecked
                    ? SizedBox(
                        height: 48,
                        child: PhoneTextField(
                          controller: _phoneController,
                          controller2: _nationController,
                          controller3: _isoCodeController,
                          onChanged: (value) {
                            setState(() {
                              friendID = 0;
                            });
                          },
                          onSubmit: () async {
                            await _searchByPhone(_phoneController.text != ""
                                ? _phoneController.text.startsWith('0')
                                    ? _nationController.text +
                                        _phoneController.text.substring(1)
                                    : _nationController.text +
                                        _phoneController.text
                                : "");
                          },
                        ),
                      )
                    : SizedBox(
                        height: 48,
                        child: IDTextField(
                          controller: _iDController,
                          onChanged: (value) {
                            setState(() {
                              friendID = 0;
                            });
                          },
                          onSubmit: (value) async {
                            await _searchByUserID(_iDController.text);
                          },
                        ),
                      ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppStyle.blue[100],
          ),
          if (friendID != null && friendID != 0)
            Expanded(
              child: profile(
                context,
                id: friendID!,
                isDialog: false,
              ),
            ),
          if (friendID == null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/fail_logo_dark.png"),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "查無結果",
                      style:
                          AppStyle.info(level: 2, color: AppStyle.gray[700]!),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
