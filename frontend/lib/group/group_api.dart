import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';
import 'package:image_picker/image_picker.dart';

class GetInfoAPI {
  static String? token;
  static Future<List<Map<String, dynamic>>> getFriend() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friends'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> friendsWithInfo = [];
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> infoData = responseData['data'];
      final List<Map<String, dynamic>> friendsID = infoData.map((friend) {
        return {
          "id": friend['friend_id'],
          "nickname": friend['nickname'],
        };
      }).toList();

      for (var friend in friendsID) {
        var id = friend['id'];
        var infoResponse = await http.get(
          Uri(scheme: 'https', host: host, path: '/api/member/$id/info'),
        );
        if (infoResponse.statusCode == 200) {
          final Map<String, dynamic> infoResponseData =
              json.decode(infoResponse.body);
          final Map<String, dynamic> infoInfoData = infoResponseData['data'];
          Map<String, dynamic> friendInfo = {
            "id": id,
            "nickname": friend['nickname'],
            "photo": infoInfoData['photo']['url'],
            "check": false,
          };
          friendsWithInfo.add(friendInfo);
        } else {
          throw Exception(
              'API request failed with status ${infoResponse.statusCode}');
        }
      }

      return friendsWithInfo;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class GroupAPI {
  static String? token;
  static Future<int> createGroup(
      {String? name, XFile? avatar, XFile? background}) async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    var request = http.MultipartRequest(
        'POST', Uri(scheme: 'https', host: host, path: '/api/groups'));
    request.headers['Authorization'] = token ?? "";
    if (name != null) {
      request.fields['name'] = name;
    }
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
}
