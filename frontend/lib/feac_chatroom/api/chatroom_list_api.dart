import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatRoomList {
  static Future<List<Map<String, dynamic>>> fetchChatRooms() async {
    final headers = {
      //這裡要改成傳值
      'Authorization':
          'Bearer eyJhY2Nlc3MtdG9rZW4iOiJMYVFsZVJ5c1VqUEwxdmVYQWY1U3J3IiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IkV6bkFKeGpIcDBabXJVbW5zTzk3dkEiLCJleHBpcnkiOiIxNjkzNDk3ODgwIiwidWlkIjoiZXhhbXBsZTFAZ21haWwuY29tIn0=', // 替換為你的授權標頭
    };
    final response = await http.get(
        Uri.parse('http://localhost:3000/api/chatroom'), //這裡要改成分支domain
        headers: headers);

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
