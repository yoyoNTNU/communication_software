import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/search/search_widget.dart';

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
            height: 104,
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
                        height: 40,
                        child: PhoneTextField(
                          controller: _phoneController,
                          controller2: _nationController,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        child: IDTextField(
                          controller: _iDController,
                          onChanged: (value) {
                            setState(() {});
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
