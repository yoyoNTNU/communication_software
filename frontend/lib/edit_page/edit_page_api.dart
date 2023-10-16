import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class GetDetailAPI {
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

class SetDetailAPI {
  static Future<int> modifyInfo(
      {String? name,
      String? birthday,
      String? intro,
      String? isLoginMail}) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final Map<String, String> body_ = {};
    if (name != null) {
      body_["name"] = name;
    }
    if (birthday != null) {
      body_["birthday"] = birthday;
    }
    if (intro != null) {
      body_["introduction"] = intro;
    }
    if (isLoginMail != null) {
      body_["isLoginMail"] = isLoginMail;
    }
    final response = await http.patch(
        Uri(scheme: 'https', host: host, path: '/api/member/info'),
        headers: {'Authorization': token ?? ""},
        body: body_);
    return response.statusCode;
  }

  static Future<int> modifyPwd(
      String oldPwd, String newPed, String confirmPwd) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final Map<String, String> body_ = {
      "current_password": oldPwd,
      "password": newPed,
      "password_confirmation": confirmPwd
    };
    final response = await http.put(
        Uri(scheme: 'https', host: host, path: '/auth/member/password'),
        headers: {'Authorization': token ?? ""},
        body: body_);
    return response.statusCode;
  }

  static Future<int> modifyPhoto({XFile? avatar, XFile? background}) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    var request = http.MultipartRequest(
        'PATCH', Uri(scheme: 'https', host: host, path: '/api/member/info'));
    request.headers['Authorization'] = token ?? "";
    if (avatar != null) {
      var file = await http.MultipartFile.fromPath('photo', avatar.path);
      request.files.add(file);
    }
    if (background != null) {
      var file =
          await http.MultipartFile.fromPath('background', background.path);
      request.files.add(file);
    }
    var response = await request.send();
    return response.statusCode;
  }

  static Future<int> removeAvatar() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.delete(
        Uri(scheme: 'https', host: host, path: '/api/member/delete_avatar'),
        headers: {'Authorization': token ?? ""});
    return response.statusCode;
  }

  static Future<int> removeBackground() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.delete(
        Uri(scheme: 'https', host: host, path: '/api/member/delete_background'),
        headers: {'Authorization': token ?? ""});
    return response.statusCode;
  }
}
