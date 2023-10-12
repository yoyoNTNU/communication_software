import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class ChatRoomList {
  static Future<List<Map<String, dynamic>>> fetchChatRooms() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/chatroom'),
      headers: {'Authorization': token ?? ""},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> chatroomData = responseData['data'];
      final List<Map<String, dynamic>> fetchedChatRooms =
          chatroomData.map((room) {
        final chatroom = room['chatroom'];
        final message = room['message'];
        final cm = room['c_m'];
        final name = room['name'];
        final photo = room['photo'];
        final isRead = room['isRead'];
        return {
          "chatroomID": chatroom['id'],
          "messageID": message['id'],
          "messageContent": message['content'],
          "messageType": message['type_'],
          "messageTime": message['created_at'],
          "cmIsPinned": cm['isPinned'],
          "cmIsMuted": cm['isMuted'],
          "name": name,
          "photo": photo != null ? photo['url'] : null,
          "isRead": isRead,
        };
      }).toList();

      return fetchedChatRooms;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}
