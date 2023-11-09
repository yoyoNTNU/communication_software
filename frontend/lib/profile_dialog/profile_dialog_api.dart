import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class FriendAPI {
  static String? token;

  static Future<Map<String, dynamic>> getCheckFriend(int friendID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friends/$friendID/check'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      final String? message = infoData['message'];
      return {
        "relationship": infoData['relationship'],
        "message": message,
      };
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
      final Map<String, dynamic> infoData = responseData['data'];
      final Map<String, dynamic> info = {
        "memberID": infoData['id'],
        "userID": infoData['user_id'],
        "name": infoData['name'] ?? "",
        "intro": infoData['introduction'] ?? "",
        "photo":
            infoData['photo'] == null ? "" : infoData['photo']['url'] ?? "",
        "background": infoData['background'] == null
            ? ""
            : infoData['background']['url'] ?? "",
      };
      return info;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getFriendInfo(int friendID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friends/$friendID'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      final Map<String, dynamic> info = {
        "memberID": friendID,
        "userID": infoData['user_id'],
        "name": infoData['name'] ?? "",
        "intro": infoData['introduction'] ?? "",
        "photo":
            infoData['photo'] == null ? "" : infoData['photo']['url'] ?? "",
        "background": infoData['background'] == null
            ? ""
            : infoData['background']['url'] ?? "",
      };
      return info;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<int> updateNickname(int friendID, String name) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.patch(
      Uri(scheme: 'https', host: host, path: '/api/friends/$friendID'),
      headers: {'Authorization': token ?? ""},
      body: {"nickname": name},
    );
    return response.statusCode;
  }

  static Future<String> getFriendOriginName(int friendID) async {
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/member/$friendID/info'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      return infoData['name'];
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<int> deleteFriend(int friendID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.delete(
      Uri(scheme: 'https', host: host, path: '/api/friends/$friendID'),
      headers: {'Authorization': token ?? ""},
    );
    return response.statusCode;
  }
}

class GetGroupAPI {
  static Future<Map<String, dynamic>> getGroupInfo(int groupID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/groups/$groupID'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      final Map<String, dynamic> info = {
        "groupID": infoData['id'],
        "name": infoData['name'] ?? "",
        "photo":
            infoData['photo'] == null ? "" : infoData['photo']['url'] ?? "",
        "background": infoData['background'] == null
            ? ""
            : infoData['background']['url'] ?? "",
      };
      return info;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class TransferAPI {
  static Future<int> typeIDToChatroomID(
    String type, {
    int friendID = 0,
    int groupID = 0,
  }) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final memberID = dbToken?.userID;
    final response = await http.get(Uri.parse(
        'https://$host/TypeIDToChatroomID?type_=$type&member_id_1=$memberID&member_id_2=$friendID&group_id=$groupID'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];
      return infoData['id'];
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class HelperAPI {
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
}
