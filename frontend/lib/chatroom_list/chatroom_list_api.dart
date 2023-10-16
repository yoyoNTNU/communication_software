import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class ChatRoomListAPI {
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
        final photo = room['photo'];
        return {
          "chatroomID": chatroom['id'],
          "messageID": message['id'],
          "messageContent": message['content'],
          "messageType": message['type_'],
          "messageTime": message['created_at'],
          "cmIsPinned": cm['isPinned'],
          "cmIsMuted": cm['isMuted'],
          "name": room['name'],
          "photo": photo != null ? photo['url'] : null,
          "isRead": room['isRead'],
          "type": room['chatroom_type'],
          "count": room['count'],
          "sender": room['sender'],
        };
      }).toList();

      return fetchedChatRooms;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class ChatRoomRowAPI {
  static Future<int> getUnreadCount(int chatroomID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/${chatroomID.toString()}/unread'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['data'];
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<void> updateSetting(int chatroomID, bool isPinned, bool isMuted,
      bool isDisabled, DateTime? deleteAt) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    await http.patch(
        Uri(
            scheme: 'https',
            host: host,
            path: '/api/chatroom/${chatroomID.toString()}'),
        headers: {
          'Authorization': token ?? ""
        },
        body: {
          'isDisabled': isDisabled.toString(),
          'isMuted': isMuted.toString(),
          'isPinned': isPinned.toString(),
          'delete_at': deleteAt.toString(),
        });
  }

  static Future<void> readAllMessage(int chatroomID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    await http.post(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/${chatroomID.toString()}/read'),
      headers: {'Authorization': token ?? ""},
    );
  }

  static Future<void> unReadAllMessage(int chatroomID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    await http.delete(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/${chatroomID.toString()}/unread'),
      headers: {'Authorization': token ?? ""},
    );
  }
}
