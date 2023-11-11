part of 'profile_dialog_widget.dart';

class ReceiverArea extends StatefulWidget {
  const ReceiverArea({
    super.key,
  });

  @override
  State<ReceiverArea> createState() => _ReceiverAreaState();
}

class _ReceiverAreaState extends State<ReceiverArea> {
  final TextEditingController _inviteController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
      builder: (context, state) {
        if (state is FriendProfile) {
          _inviteController.text = state.message ?? "";
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: AppStyle.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          height: 156,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "收到一則好友邀請",
                style: AppStyle.header(level: 3, color: AppStyle.gray[700]!),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 36,
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
                    counterText: "",
                    filled: true,
                    fillColor: AppStyle.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppStyle.blue[300]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppStyle.blue[300]!, width: 1),
                    ),
                  ),
                  maxLines: null,
                  maxLength: 20,
                ),
              ),
              const SizedBox(
                height: 18,
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
                        await FriendAPI.acceptInvite(state.data['memberID']);
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
                          Image.asset("assets/icons/agree.png"),
                          Text(
                            '同意邀請',
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
                      onTap: () async {
                        int tempID = state.data['memberID'];
                        if (!mounted) return;
                        showLoading(context);
                        await FriendAPI.rejectInvite(state.data['memberID']);
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
                          Image.asset("assets/icons/reject.png"),
                          Text(
                            '拒絕邀請',
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
            ],
          ),
        );
      },
    );
  }
}
