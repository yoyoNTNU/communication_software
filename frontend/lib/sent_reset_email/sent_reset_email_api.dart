import 'package:http/http.dart' as http;
import 'package:proj/main.dart';

class ResetEmailAPI {
  static Future<int> sentResetEmail(String email) async {
    final Map<String, String> body_ = {
      'email': email,
      'redirect_url': 'auth/member/password/reset'
    };
    final response = await http.post(
        Uri(scheme: 'https', host: host, path: '/auth/member/password'),
        body: body_);

    return response.statusCode;
  }
}
