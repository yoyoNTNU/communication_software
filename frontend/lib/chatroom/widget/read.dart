part of 'chatroom_widget.dart';

String readCount(int? count, String chatroomType) {
  if (chatroomType == "friend") {
    if (count == 1 || count == null) {
      return "";
    } else {
      return "已讀·";
    }
  } else {
    if (count == 1 || count == null) {
      return "";
    } else {
      return "已讀 ${count! - 1}·";
    }
  }
}
