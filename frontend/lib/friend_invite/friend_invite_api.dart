import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj/main.dart';
import 'package:proj/data.dart';

class GetInfoAPI {
  static Future<List<Map<String, dynamic>>> getConfirm() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friend_requests'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> friendsWithInfo = [];
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> infoData = responseData['data']['received'];
      final List<Map<String, dynamic>> friendsID = infoData.map((friend) {
        return {
          "id": friend['member_id'],
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
            "nickname": infoInfoData['name'],
            "photo": infoInfoData['photo']['url'],
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

  static Future<List<Map<String, dynamic>>> getSent() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/friend_requests'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> friendsWithInfo = [];
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> infoData = responseData['data']['send'];
      final List<Map<String, dynamic>> friendsID = infoData.map((friend) {
        return {
          "id": friend['friend_id'],
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
            "nickname": infoInfoData['name'],
            "photo": infoInfoData['photo']['url'],
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
