part of 'chatroom_widget.dart';

String readCount(int chatroomID, String chatroomType) {
  //去撈messageReader資料
  int count = chatroomID; //暫用
  if (chatroomType == "friend") {
    if (count == 1) {
      return "";
    } else {
      return "已讀·";
    }
  } else {
    if (count == 1) {
      return "";
    } else {
      return "已讀 ${count - 1}·";
    }
  }
}
