part of 'profile_dialog_widget.dart';

class CommonArea extends StatefulWidget {
  final String? name;
  const CommonArea({
    super.key,
    required this.name,
  });

  @override
  State<CommonArea> createState() => _CommonAreaState();
}

class _CommonAreaState extends State<CommonArea> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
        builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              // Photo Area
              GestureDetector(
                onTap: () {
                  (state.data['background'] != "" &&
                          state.data['background'] != null)
                      ? fullViewImage(context, state.data['background'],
                          isNeedEdit:
                              state is SelfProfile || state is GroupProfile,
                          title: "封面相片")
                      : null;
                },
                child: Container(
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
                    child: GestureDetector(
                      onTap: () {
                        (state.data['photo'] != "" &&
                                state.data['photo'] != null)
                            ? fullViewImage(context, state.data['photo'],
                                isNeedEdit: state is SelfProfile ||
                                    state is GroupProfile,
                                title: "頭貼相片")
                            : null;
                      },
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
                ),
              ),
              const SizedBox(height: 8),
              // Text Area
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.name != null ? widget.name! : "",
                      style: AppStyle.header(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (state.data['intro'] != null || state is GroupProfile)
                      const SizedBox(height: 4),
                    if (state.data['intro'] != null)
                      Text(
                        state.data['intro'].toString(),
                        style: AppStyle.body(color: AppStyle.teal),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (state is GroupProfile)
                      Container(
                        height: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: AppStyle.teal),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/user_teal.png",
                              width: 12,
                              height: 18,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              state.memberCount.toString(),
                              style:
                                  AppStyle.info(level: 2, color: AppStyle.teal),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      );
    });
  }
}
