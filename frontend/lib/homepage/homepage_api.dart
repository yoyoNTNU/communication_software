import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class GetInfoAPI {
  static String? token;
  static bool isTokenInitialized = false;

  static Future<void> initializeToken() async {
    if (!isTokenInitialized) {
      final dbToken = await DatabaseHelper.instance.getToken();
      token = dbToken?.authorization;
      isTokenInitialized = true;
      print("init");
    }
  }

  static Future<Map<String, dynamic>> getInfo() async {
    await initializeToken();
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
        "name": infoData['name'],
        "photo": infoData['photo'] == null ? null : infoData['photo']['url'],
        "background": infoData['background'] == null
            ? null
            : infoData['background']['url'],
      };

      return info;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> getFriend() async {
    await initializeToken();
    dynamic response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friends'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> infoData = responseData['data'];
      List<Map<String, dynamic>> friendsID = infoData.map((friend) {
        return {
          "id": friend['friend_id'],
          "nickname": friend['nickname'],
        };
      }).toList();

      response = await http.get(
        Uri(scheme: 'https', host: host, path: '/api/friends'),
        headers: {'Authorization': token ?? ""},
      );

      return friendsID;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}
