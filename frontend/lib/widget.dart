import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj/profile_dialog/profile_dialog_screen.dart';
import 'package:proj/style.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
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

// Dialog Showing the profile of user
void showProfileDialog(
  BuildContext context, {
  bool isGroup = false,
  int id = -1,
  int groupMemberCount = 0,
}) {
  showProfile(
    context,
    isGroup: isGroup,
    id: id,
    groupMemberCount: groupMemberCount,
  );
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  SnackBar snackBar = SnackBar(
    content: Text(
      '已複製到剪貼板',
      style: AppStyle.body(color: AppStyle.white),
    ),
    duration: const Duration(milliseconds: 1500),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void fullViewImage(
  BuildContext context,
  String content, {
  String title = "",
  bool isNeedDownload = false,
  bool isNeedEdit = false,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        //要有下載按鈕
        return Column(
          children: [
            Container(
              height: 86,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  isNeedDownload
                      ? GestureDetector(
                          onTap: () {
                            print("下載圖片");
                            //TODO: 下載圖片
                          },
                          child: Image.asset("assets/icons/download.png"),
                        )
                      : const SizedBox(
                          width: 24,
                          height: 24,
                        ),
                  Expanded(
                    child: Text(
                      title,
                      style: AppStyle.header(color: AppStyle.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset("assets/icons/x_white.png"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRect(
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: PhotoView(
                    backgroundDecoration:
                        BoxDecoration(color: Colors.grey.shade900),
                    imageProvider: NetworkImage(content),
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 1.5,
                  ),
                ),
              ),
            ),
            if (isNeedEdit)
              Container(
                height: 86,
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: OutlinedButton(
                  onPressed: () {
                    print("顯示相片來源選單");
                  },
                  style: AppStyle.secondaryBtn(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset("assets/icons/edit_teal.png"),
                      ),
                      const SizedBox(width: 8),
                      const Text("編輯"),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    ),
  );
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
                  Image.asset("assets/icons/camera.png"),
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
