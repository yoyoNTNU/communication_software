import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class GetDetailAPI {
  static String? token;
  static bool isTokenInitialized = false;

  static Future<Map<String, dynamic>> getInfo() async {
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
        "name": infoData['name'],
        "intro": infoData['introduction'],
        "birthday": infoData['birthday'],
        "email": infoData['email'],
        "phone": infoData['phone'],
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
}
