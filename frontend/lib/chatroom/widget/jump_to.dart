part of 'chatroom_widget.dart';

Future<void> jumpTo(
  BuildContext context,
  ScrollController scrollController,
  void Function({int msgID, bool isNeedShake}) setWidgetShake, {
  List<Map<String, dynamic>> msgTileHeights = const [],
  int targetID = 0,
}) async {
  double targetPosition = 0;
  List<Map<String, dynamic>> list = msgTileHeights
      .where((element) => element["messageID"] < targetID)
      .toList();
  for (var map in list) {
    targetPosition += map["height"];
  }

  scrollController.jumpTo(
    targetPosition - 100,
  );

  setWidgetShake(msgID: targetID, isNeedShake: true);
  await Future.delayed(const Duration(milliseconds: 200));
  setWidgetShake(msgID: targetID, isNeedShake: false);
}
