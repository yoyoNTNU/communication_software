part of 'chatroom_widget.dart';

Future<String> readCount(int? messageID, String chatroomType) async {
  int count;
  if (messageID != null) {
    try {
      count = await MessageAPI.getReadCount(messageID);
    } catch (e) {
      count = 1;
      print("API request error: $e");
    }
  } else {
    count = 1;
  }
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
