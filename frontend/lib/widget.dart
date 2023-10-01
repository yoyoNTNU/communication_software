import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj/style.dart';
import 'dart:io';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Image.asset('assets/animations/loading.gif')],
        ),
      ),
    );
  }
}

void showLoading(BuildContext context) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );
  });
}

//final ImagePicker picker = ImagePicker();
// Pick an image.
// final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
// final XFile? photo = await picker.pickImage(source: ImageSource.camera);
// Pick a video.
// final XFile? galleryVideo = await picker.pickVideo(source: ImageSource.gallery);
// Capture a video.
// final XFile? cameraVideo = await picker.pickVideo(source: ImageSource.camera);
// Pick multiple images.
// final List<XFile> images = await picker.pickMultiImage();
// Pick singe image or video.
// final XFile? media = await picker.pickMedia();
// Pick multiple images and videos.
// final List<XFile> medias = await picker.pickMultipleMedia();

Future<XFile?> selectSinglePhoto() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<XFile?> takeSinglePhoto() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

Future<XFile?> photoSource(BuildContext context) async {
  final String? temp;
  if (Platform.isAndroid || Platform.isIOS) {
    temp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop("take");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/Camera.png"),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "透過相機拍攝",
                    style: AppStyle.body(),
                  )
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop("pick");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/img_box_black.png"),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "透過相簿選擇",
                    style: AppStyle.body(),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  } else {
    temp = "pick";
  }
  if (temp != null) {
    XFile? photo;
    if (temp == "pick") {
      photo = await selectSinglePhoto();
    } else {
      photo = await takeSinglePhoto();
    }
    return photo;
  } else {
    return null;
  }
}
