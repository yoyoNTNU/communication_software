import 'package:proj/friend_invite/friend_invite_widget.dart';
import 'package:proj/style.dart';
import 'package:flutter/material.dart';

class FriendInvite extends StatefulWidget {
  const FriendInvite({super.key});
  @override
  State<FriendInvite> createState() => _FriendInviteState();
}

class _FriendInviteState extends State<FriendInvite> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.blue[50],
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.popAndPushNamed(context, '/home'),
              child: Image.asset("assets/icons/left.png")),
          title: Text(
            '好友邀請',
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    ConfirmList(),
                    const SizedBox(height: 24),
                    SentList(),
                    const SizedBox(height: 24),
                    
                  ],
                ),
              ),
            ],
          ),
        )
    );  
  }
}