part of 'chatroom_widget.dart';

String dateTimeToString(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime).toString();
}

String dateTimeStringToString(String dateTime) {
  return DateFormat('h:mm a')
      .format(DateTime.parse(dateTime).toLocal())
      .toString();
}
