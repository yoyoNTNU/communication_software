import 'package:proj/friend_invite/widget/friend_invite_widget.dart';
import 'package:proj/style.dart';
import 'package:flutter/material.dart';

class FriendInvite extends StatefulWidget {
  const FriendInvite({super.key});
  @override
  State<FriendInvite> createState() => _FriendInviteState();
}

class _FriendInviteState extends State<FriendInvite> {
  final ScrollController _scrollController = ScrollController();
  void _onLoaded() {
    if (!context.mounted) return;
    Navigator.of(context).pop();
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
                    const ConfirmList(),
                    const SizedBox(height: 24),
                    SentList(onLoaded: _onLoaded),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
