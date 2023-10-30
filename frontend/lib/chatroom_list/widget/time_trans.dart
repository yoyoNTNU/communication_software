part of 'chatroom_list_widget.dart';

String timeTrans(String messageTime) {
  final DateTime now = DateTime.now();
  final DateTime uctDateTime = DateTime.parse(messageTime);
  DateTime messageDateTime = uctDateTime.toLocal();
  if (now.year == messageDateTime.year &&
      now.month == messageDateTime.month &&
      now.day == messageDateTime.day) {
    // 同一天，顯示(上午/下午 hh:mm)
    final String period = messageDateTime.hour < 12 ? '上午' : '下午';

    final String time = DateFormat('hh:mm').format(messageDateTime);
    return '$period $time';
  } else if (now.year == messageDateTime.year &&
      now.month == messageDateTime.month &&
      now.day - messageDateTime.day == 1) {
    // 前一天，顯示"昨天"
    return '昨天';
  } else if (now.year == messageDateTime.year &&
      now.month == messageDateTime.month &&
      now.day - messageDateTime.day < 7) {
    // 一周內，顯示星期幾
    switch (messageDateTime.weekday) {
      case 1:
        return '星期一';
      case 2:
        return '星期二';
      case 3:
        return '星期三';
      case 4:
        return '星期四';
      case 5:
        return '星期五';
      case 6:
        return '星期六';
      case 7:
        return '星期日';
    }
    return 'error';
  } else {
    // 更之前，顯示月份/日期
    return DateFormat('MM/dd').format(messageDateTime);
  }
}
