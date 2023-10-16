import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class SearchAPI {
  static Future<Map<String, dynamic>> byPhone(
    String phone,
  ) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri.parse(
          'https://$host/api/search/phone?phone=${Uri.encodeComponent(phone)}'),
      headers: {'Authorization': token ?? ""},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> data = responseData['data'];
      final Map<String, dynamic> message = {
        'state': response.statusCode,
        'id': data['id']
      };
      return message;
    } else {
      return {'state': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> byUserID(
    String userID,
  ) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri.parse('https://$host/api/search/user_id?user_id=$userID'),
      headers: {'Authorization': token ?? ""},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> data = responseData['data'];
      final Map<String, dynamic> message = {
        'state': response.statusCode,
        'id': data['id']
      };
      return message;
    } else {
      return {'state': response.statusCode};
    }
  }
}
