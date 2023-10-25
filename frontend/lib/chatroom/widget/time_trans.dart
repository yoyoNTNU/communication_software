part of 'chatroom_widget.dart';

String timeTrans(String duration) {
  String hour, min, sec, content = "";
  List<String> temp = duration.split(':');
  hour = temp[0];
  if (hour.startsWith("0")) {
    hour = hour[1];
  }
  min = temp[1];
  if (min.startsWith("0")) {
    min = min[1];
  }
  sec = temp[2];
  if (sec.startsWith("0")) {
    sec = sec[1];
  }
  if (hour != "0") {
    content = "$hour 時 ";
  }
  if (content != "" || min != "0") {
    content = "$content$min 分 ";
  }
  if (content != "" || sec != "0") {
    content = "$content$sec 秒 ";
  }
  return content;
}
