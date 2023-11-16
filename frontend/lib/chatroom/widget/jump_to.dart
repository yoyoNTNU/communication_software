part of 'chatroom_widget.dart';

void jumpTo(
  BuildContext context,
  ScrollController scrollController, {
  List<Map<String, dynamic>> msgTileHeights = const [],
  int targetID = 0,
}) {
  double targetPosition = 0;
  List<Map<String, dynamic>> list = msgTileHeights
      .where((element) => element["messageID"] < targetID)
      .toList();
  for (var map in list) {
    targetPosition += map["height"];
  }

  scrollController.animateTo(
    targetPosition - 100,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}
