import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/profile_dialog/bloc/profile_dialog_bloc.dart';
import 'package:proj/style.dart';

// Dialog Showing the profile of user
void showProfileDialog(BuildContext context,
    {bool isGroup = false, int id = -1}) {
  BlocProvider.of<ProfileDialogBloc>(context).add(OpenProfile(
    userID: id,
    isGroup: isGroup,
  ));
  showDialog(context: context, builder: (context) => ProfileDialog(userID: id));
}

// Create a Dialog that show the profile of user
class ProfileDialog extends StatefulWidget {
  final int userID;

  const ProfileDialog({Key? key, required this.userID}) : super(key: key);

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
                          image: NetworkImage(state.data['background'] ?? ""),
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
                              image: NetworkImage(state.data['photo'] ?? ""),
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
                            state.data['name'].toString(),
                            style: AppStyle.header(),
                          ),
                          const SizedBox(height: 4),
                          if (state.data['intro'] != null)
                            Text(
                              state.data['intro'].toString(),
                              style: AppStyle.body(),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Button Area
                    if (state is SelfProfile)
                      const Text("This is your profile"),
                    if (state is FriendProfile && state.isFriend)
                      const Text("You are friends"),
                    if (state is FriendProfile && !state.isFriend)
                      const Text("You are not friends"),
                  ],
                ),
              ),
            ),
            // A Button to close the dialog
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
                  child: Image.asset("assets/icons/X.png"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
