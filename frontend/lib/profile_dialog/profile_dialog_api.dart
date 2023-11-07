import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class GetFriendAPI {
  static String? token;

  static Future<String> getCheckFriend(int friendID) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friends/$friendID/check'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> infoData = responseData['data'];

      return infoData['relationship'];
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
}
