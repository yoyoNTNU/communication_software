part of 'profile_dialog_widget.dart';

class NoneArea extends StatefulWidget {
  const NoneArea({
    super.key,
  });

  @override
  State<NoneArea> createState() => _NoneAreaState();
}

class _NoneAreaState extends State<NoneArea> {
  bool isInput = false;
  final TextEditingController _inviteController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
      builder: (context, state) {
        return isInput
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
                      style:
                          AppStyle.header(level: 3, color: AppStyle.gray[700]!),
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
                          hintStyle: AppStyle.body(color: AppStyle.gray[300]!),
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
                        maxLength: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              int tempID = state.data['memberID'];
                              if (!mounted) return;
                              showLoading(context);
                              await FriendAPI.sentInvite(state.data['memberID'],
                                  _inviteController.text);
                              if (!mounted) return;
                              Navigator.pop(context);
                              BlocProvider.of<ProfileDialogBloc>(context)
                                  .add(ResetProfile());
                              BlocProvider.of<ProfileDialogBloc>(context)
                                  .add(OpenProfile(id: tempID));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
            : Container(
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
              );
      },
    );
  }
}
