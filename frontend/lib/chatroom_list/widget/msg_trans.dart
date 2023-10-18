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
    //TODO: 電話跟視訊跟音訊類別

    // case "call":
    //   content = "";
    //   break;
    // case "view":
    //   content = "";
    //   break;
    case "info":
      content = "傳送了一個聯絡資訊";
      break;
    default:
      content = "未知的類別";
      break;
  }
  return content;
}
