import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';
import 'package:proj/chatroom/widget/chatroom_widget.dart';

class MessageAPI {
  static Future<List<Map<String, dynamic>>> allMessage(int chatroomID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/${chatroomID.toString()}/message'),
      headers: {'Authorization': token ?? ""},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> messageData = responseData['data'];
      final List<Map<String, dynamic>> messages = messageData.map((msg) {
        final file = msg['file'];
        final t = msg['type_'];
        return {
          "messageID": msg['id'],
          "senderID": msg['member_id'],
          "type": t,
          "content":
              (t == "string" || t == "view" || t == "call" || t == "info")
                  ? msg['content']
                  : file['url'],
          "msgTime": dateTimeStringToString(msg['created_at']),
          "replyToID": msg['reply_to_id'],
          "isReply": msg['isReply'],
          "isPinned": msg['isPinned'],
          "updatedAt": msg['updated_at'],
        };
      }).toList();
      return messages;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getMessage(int messageID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/0/message/${messageID.toString()}'),
      headers: {'Authorization': token ?? ""},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic msg = responseData['data'];
      final t = msg['type_'];
      final Map<String, dynamic> message = {
        "messageID": msg['id'],
        "senderID": msg['member_id'],
        "type": t,
        "content": (t == "string" || t == "view" || t == "call" || t == "info")
            ? msg['content']
            : msg['file']['url'],
        "msgTime": dateTimeStringToString(msg['created_at']),
        "replyToID": msg['reply_to_id'],
        "isReply": msg['isReply'],
        "isPinned": msg['isPinned'],
        "updatedAt": msg['updated_at'],
      };
      return message;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<int> sentContentMessage(
    int chatroomID, {
    String type = "",
    String content = "",
    bool isReply = false,
    int replyToID = 0,
  }) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.post(
        Uri(
            scheme: 'https',
            host: host,
            path: '/api/chatroom/${chatroomID.toString()}/message'),
        headers: {
          'Authorization': token ?? ""
        },
        body: {
          "type_": type,
          "content": content,
          "reply_to_id": replyToID,
          "isReply": isReply
        });
    return response.statusCode;
  }

  static Future<Map<String, int>> sentXFileMessage(
    int chatroomID, {
    String type = "",
    XFile? file,
  }) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    var request = http.MultipartRequest(
        'POST',
        Uri(
            scheme: 'https',
            host: host,
            path: '/api/chatroom/$chatroomID/message'));
    request.headers['Authorization'] = token ?? "";
    request.fields['type_'] = type;

    if (file != null) {
      var tempFile = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(tempFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      final jsonString = await utf8.decodeStream(response.stream);
      final Map<String, dynamic> data = json.decode(jsonString);
      return {
        "status": response.statusCode,
        "msgID": data['data']['id'],
      };
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<int> deleteMessage(int messageID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.delete(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/0/message/${messageID.toString()}'),
      headers: {'Authorization': token ?? ""},
    );
    return response.statusCode;
  }

  static Future<int> readMessage(int chatroomID, int messageID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.post(
      Uri(
          scheme: 'https',
          host: host,
          path:
              '/api/chatroom/${chatroomID.toString()}/message/${messageID.toString()}/read'),
      headers: {'Authorization': token ?? ""},
    );
    return response.statusCode;
  }

  static Future<int> setIsPinned(int messageID, bool isPinned) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.patch(
        Uri(
            scheme: 'https',
            host: host,
            path: '/api/chatroom/0/message/${messageID.toString()}'),
        headers: {'Authorization': token ?? ""},
        body: {"isPinned": isPinned.toString()});
    return response.statusCode;
  }

  static Future<int> getReadCount(int messageID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/0/message/$messageID/read_count'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final int count = responseData['data'];
      return count;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class MemberAPI {
  static Future<Map<String, dynamic>> getMemberInfo(int memberID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/friends/${memberID.toString()}'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic member = responseData['data'];
      final Map<String, dynamic> m = {
        "name": member['name'],
        "avatar": member['photo'] == null ? null : member['photo']['url'],
      };
      return m;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getSelfInfo() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/member/info'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic member = responseData['data'];
      final Map<String, dynamic> m = {
        "name": member['name'],
        "avatar": member['photo'] == null ? null : member['photo']['url'],
      };
      return m;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class ChatroomAPI {
  static Future<Map<String, dynamic>> getChatroom(int chatroomID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/chatroom/${chatroomID.toString()}'),
      headers: {'Authorization': token ?? ""},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic chatroom = responseData['data'];
      final Map<String, dynamic> c = {
        "chatroomName": chatroom['name'],
        "type": chatroom['type_'],
        "isPinned": chatroom['isPinned'],
        "isMuted": chatroom['isMuted'],
        "background": chatroom['file'] == null ? null : chatroom['file']['url'],
      };
      return c;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getGroupMember(int groupID) async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: host,
          path: '/api/groups/$groupID/member_list'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoInfoData2 = responseData['data'];
      Map<String, dynamic> groupsWithInfo = {};
      groupsWithInfo["count"] = infoInfoData2['count'];
      groupsWithInfo["member"] = infoInfoData2['member'];
      return groupsWithInfo;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class TransferAPI {
  static Future<int> chatroomIDtoGroupID(int chatroomID) async {
    final response = await http.get(
        Uri.parse('https://$host/ChatroomIDToTypeID?chatroom_id=$chatroomID'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      return infoData['group_id'];
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<List<int>> chatroomIDtoFriendID(int chatroomID) async {
    final response = await http.get(
        Uri.parse('https://$host/ChatroomIDToTypeID?chatroom_id=$chatroomID'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      return [infoData['member_id_1'], infoData['member_id_2']];
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}
