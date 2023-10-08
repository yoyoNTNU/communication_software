part of 'group_widget.dart';

bool checkFileType(XFile file) {
  String filePath = file.path;
  String fileExtension = filePath.split('.').last.toLowerCase();

  if (fileExtension == 'jpg' ||
      fileExtension == 'jpeg' ||
      fileExtension == 'png' ||
      fileExtension == 'gif') {
    return true;
  } else {
    return false;
  }
}