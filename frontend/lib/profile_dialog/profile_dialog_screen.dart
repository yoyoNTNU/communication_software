import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/profile_dialog/bloc/profile_dialog_bloc.dart';
import 'package:proj/profile_dialog/widget/profile_dialog_widget.dart';
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
                    const CommonArea(),
                    // Button Area
                    if (state is SelfProfile) const SelfArea(),
                    if (state is FriendProfile && state.isFriend)
                      const FriendArea(),
                    if (state is FriendProfile && state.isReceiver)
                      const ReceiverArea(),
                    if (state is FriendProfile && state.isSender)
                      const SenderArea(),
                    if (state is FriendProfile &&
                        !state.isFriend &&
                        !state.isSender &&
                        !state.isReceiver)
                      const NoneArea(),
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
