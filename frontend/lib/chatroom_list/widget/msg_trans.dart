part of 'chatroom_list_widget.dart';

String msgTrans(String messageType) {
  final String content;
  switch (messageType) {
    case "photo":
      content = "傳送了一張相片";
      break;
    case "video":
      content = "傳送了一個影片";
      break;
    case "file":
      content = "傳送了一個檔案";
      break;
    case "voice":
      content = "傳送了一個語音訊息";
      break;
    case "call":
      content = "撥打了一通語音通話";
      break;
    case "view":
      content = "撥打了一通視訊通話";
      break;
    case "info":
      content = "傳送了一個聯絡資訊";
      break;
    default:
      content = "未知的類別";
      break;
  }
  return content;
}
