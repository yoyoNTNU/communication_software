part of 'profile_dialog_widget.dart';

class SenderArea extends StatefulWidget {
  const SenderArea({
    super.key,
  });

  @override
  State<SenderArea> createState() => _SenderAreaState();
}

class _SenderAreaState extends State<SenderArea> {
  final TextEditingController _inviteController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
      builder: (context, state) {
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
                "好友邀請訊息",
                style: AppStyle.header(level: 3, color: AppStyle.gray[700]!),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 36,
                child: TextField(
                  readOnly: true,
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
                      onTap: () {
                        setState(() {
                          print("點擊後取消申請");
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/wait.png"),
                          Text(
                            '等待回覆',
                            style: AppStyle.caption(
                              level: 2,
                              color: AppStyle.gray[300]!,
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
