import 'package:http/http.dart' as http;
import 'package:proj/main.dart';


class AppSettingAPI {
  static Future<int> issue(
      {String? type,
      String? content}) async {
    // final dbToken = await DatabaseHelper.instance.getToken();
    // final token = dbToken?.authorization;
    final Map<String, String> body_ = {};
    if (type != null) {
      body_["type_"] = type;
    }
    if (content != null) {
      body_["content"] = content;
    }
    final response = await http.post(
        Uri(scheme: 'https', host: host, path: 'api/member/feedback'),
        body: body_);
    return response.statusCode;
  }
}
