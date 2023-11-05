import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/profile_dialog/bloc/profile_dialog_bloc.dart';
import 'package:proj/style.dart';

// Dialog Showing the profile of user
void showProfile(BuildContext context, {bool isGroup = false, int id = -1}) {
  BlocProvider.of<ProfileDialogBloc>(context).add(ResetProfile());
  BlocProvider.of<ProfileDialogBloc>(context).add(OpenProfile(
    userID: id,
    isGroup: isGroup,
  ));
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ProfileDialog(
      userID: id,
      isDialog: true,
    ),
  );
}

Widget profile(
  BuildContext context, {
  int id = -1,
  isDialog = false,
}) {
  BlocProvider.of<ProfileDialogBloc>(context).add(ResetProfile());
  BlocProvider.of<ProfileDialogBloc>(context).add(OpenProfile(
    userID: id,
  ));
  return ProfileDialog(userID: id, isDialog: isDialog);
}

// Create a Dialog that show the profile of user
class ProfileDialog extends StatefulWidget {
  final int userID;
  final bool isDialog;

  const ProfileDialog({
    Key? key,
    required this.userID,
    required this.isDialog,
  }) : super(key: key);

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  bool isInput = false;
  final TextEditingController _inviteController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: widget.isDialog ? 8 : 0,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Photo Area
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppStyle.gray,
                          width: 1,
                        ),
                        image: DecorationImage(
                          image: (state.data['background'] != "" &&
                                  state.data['background'] != null)
                              ? NetworkImage(state.data['background'])
                              : const AssetImage("assets/images/background.png")
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppStyle.gray,
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: (state.data['photo'] != "" &&
                                      state.data['photo'] != null)
                                  ? NetworkImage(state.data['photo'])
                                  : const AssetImage("assets/images/avatar.png")
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Text Area
                    Center(
                      child: Column(
                        children: [
                          Text(
                            state.data['name'] != null
                                ? state.data['name'].toString()
                                : "",
                            style: AppStyle.header(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          if (state.data['intro'] != null)
                            Text(
                              state.data['intro'].toString(),
                              style: AppStyle.body(color: AppStyle.teal),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Button Area
                    if (state is FriendProfile && state.isFriend)
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("修改暱稱");
                                  //TODO: show dialog
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icons/edit_blue.png"),
                                    Text(
                                      '修改暱稱',
                                      style: AppStyle.caption(
                                        level: 2,
                                        color: AppStyle.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("開啟聊天");
                                  //TODO: 導入聊天室
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/icons/chat_plus_blue.png"),
                                    Text(
                                      '開啟聊天',
                                      style: AppStyle.caption(
                                        level: 2,
                                        color: AppStyle.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("刪除好友");
                                  //TODO: 接API
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icons/cancel_red.png"),
                                    Text(
                                      '刪除好友',
                                      style: AppStyle.caption(
                                        level: 2,
                                        color: AppStyle.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is FriendProfile &&
                        !state.isFriend &&
                        !state.isInvited &&
                        !state.isRequested &&
                        !isInput)
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 96,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isInput = true;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/user_add.png"),
                              Text(
                                '加為好友',
                                style: AppStyle.caption(
                                  level: 2,
                                  color: AppStyle.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (state is FriendProfile &&
                        !state.isFriend &&
                        !state.isInvited &&
                        !state.isRequested &&
                        isInput)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppStyle.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 156,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              "好友邀請訊息",
                              style: AppStyle.header(
                                  level: 3, color: AppStyle.gray[700]!),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 60,
                              child: TextField(
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.search,
                                controller: _inviteController,
                                onChanged: (value) {},
                                focusNode: _focusNode,
                                style: AppStyle.body(
                                    level: 1,
                                    color: AppStyle.gray.shade900,
                                    weight: FontWeight.w500),
                                decoration: InputDecoration(
                                  hintText: "向新朋友打聲招呼吧！",
                                  hintStyle:
                                      AppStyle.body(color: AppStyle.gray[300]!),
                                  filled: true,
                                  fillColor: AppStyle.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppStyle.blue[300]!, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppStyle.blue[300]!, width: 1),
                                  ),
                                ),
                                maxLines: null,
                                maxLength: 25,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print("送出邀請");
                                      //TODO: 接API
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/icons/message.png"),
                                        Text(
                                          '送出邀請',
                                          style: AppStyle.caption(
                                            level: 2,
                                            color: AppStyle.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isInput = false;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/icons/x_gray.png"),
                                        Text(
                                          '取消',
                                          style: AppStyle.caption(
                                            level: 2,
                                            color: AppStyle.gray[700]!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            // A Button to close the dialog
            if (widget.isDialog)
              Opacity(
                opacity: 0.8,
                child: FloatingActionButton(
                  backgroundColor: AppStyle.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset("assets/icons/x.png"),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
