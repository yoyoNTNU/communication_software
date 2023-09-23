import 'package:flutter/material.dart';
import 'package:proj/edit_page/edit_page_api.dart';
import 'package:proj/edit_page/edit_page_widget.dart';
import 'package:proj/style.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.blue[50],
        appBar: AppBar(
          title: Text(
            '編輯個人資料',
            style: AppStyle.header(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Container(
                      color: AppStyle.blue[50],
                      child: accountBox(context),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      color: AppStyle.blue[50],
                      child: infoBox(context),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      color: AppStyle.blue[50],
                      child: communityBox(),
                    ),
                    // SizedBox(height: 24.0),
                    // Container(
                    //   height: 316,
                    //   child: AvatarBox(),
                    // ),
                    // SizedBox(height: 24.0),
                    // Container(
                    //   height: 336,
                    //   child: BackgroundBox(),
                    // ),
                    // SizedBox(height: 24.0),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
