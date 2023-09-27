import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
