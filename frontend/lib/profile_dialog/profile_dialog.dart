import 'package:flutter/material.dart';
import 'package:proj/style.dart';

// Dialog Showing the profile of user
void showProfileDialog(BuildContext context, int friendID) {
  showDialog(
    context: context,
    builder: (context) {
      return ProfileDialog(id: friendID);
    },
  );
}

// Create a Dialog that show the profile of user
class ProfileDialog extends StatefulWidget {
  final int id;

  const ProfileDialog({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Profile',
                  style: AppStyle.body(),
                ),
                const SizedBox(height: 10),
                Text(widget.id.toString(), style: AppStyle.body()),
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
  }
}
