import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/search/widget/search_widget.dart';
import 'package:proj/search/search_api.dart';

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
  int? friendID;

  Future<void> _searchByPhone(String phone) async {
    try {
      final Map<String, dynamic> searcher = await SearchAPI.byPhone(phone);
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
      setState(() {
        friendID = searcher['id'];
      });
    } catch (e) {
      print('API request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.blue[50],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, '/home');
          },
          child: Image.asset("assets/icons/left.png"),
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
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmit: () async {
                            await _searchByPhone(_phoneController.text != ""
                                ? _phoneController.text.startsWith('0')
                                    ? _nationController.text +
                                        _phoneController.text.substring(1)
                                    : _nationController.text +
                                        _phoneController.text
                                : "");
                            //TODO:顯示搜尋結果
                            print(friendID);
                          },
                        ),
                      )
                    : SizedBox(
                        height: 48,
                        child: IDTextField(
                          controller: _iDController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmit: (value) async {
                            await _searchByUserID(_iDController.text);
                            //TODO:顯示搜尋結果
                            print(friendID);
                          },
                        ),
                      )
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppStyle.blue[100],
          )
        ],
      ),
    );
  }
}
