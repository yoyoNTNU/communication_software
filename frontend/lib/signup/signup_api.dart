import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';

class SignUpAPI {
  static Future<Map<String, dynamic>> signUp(String email, String phone,
      String userID, String name, String password, String confirm) async {
    final Map<String, String> body_ = {
      'email': email,
      'phone': phone,
      'user_id': userID,
      'name': name,
      'password': password,
      'password_confirmation': confirm,
    };
    final response = await http.post(
        Uri(scheme: 'https', host: host, path: '/auth/member'),
        body: body_);

    if (response.statusCode != 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> errorMessage = responseData['data'];
      final Map<String, dynamic> message = {
        'state': response.statusCode,
        'email': errorMessage['email'],
        'phone': errorMessage['phone'],
        'password': errorMessage['password'],
        'password_confirmation': errorMessage['password_confirmation'],
        'name': errorMessage['name'],
        'userID': errorMessage['user_id'],
      };
      return message;
    } else {
      return {'state': response.statusCode};
    }
  }
}

class ConfirmLetterAPI {
  static Future<int> sentConfirmLetter(String email) async {
    final response = await http.post(
        Uri(scheme: 'https', host: host, path: '/auth/member/confirmation'),
        body: {'email': email});
    return response.statusCode;
  }
}
