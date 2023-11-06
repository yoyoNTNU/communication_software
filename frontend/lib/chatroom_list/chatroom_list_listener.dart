import 'package:web_socket_channel/io.dart';

class WebSocketChannel {
  static Map<int, IOWebSocketChannel> channelID = {};

  static void addListen(int id, IOWebSocketChannel channel) {
    channelID[id] = channel;
  }

  static bool checkIsSubscribe(int id) {
    return channelID.containsKey(id);
  }

  static IOWebSocketChannel? getChannel(int id) {
    return channelID[id];
  }
}
