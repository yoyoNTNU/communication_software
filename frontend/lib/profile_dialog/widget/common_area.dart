part of 'profile_dialog_widget.dart';

class CommonArea extends StatefulWidget {
  const CommonArea({
    super.key,
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
            ],
          ),
        ],
      );
    });
  }
}
