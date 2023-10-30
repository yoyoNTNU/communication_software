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

  static Future<List<Map<String, dynamic>>> getGroup() async {
    final dbToken = await DatabaseHelper.instance.getToken();
    final token = dbToken?.authorization;
    final response = await http.get(
      Uri(scheme: 'https', host: host, path: '/api/groups'),
      headers: {'Authorization': token ?? ""},
    );
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> groupsWithInfo = [];
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> infoData = responseData['data'];
      final List<Map<String, dynamic>> groupsID = infoData.map((group) {
        return {
          "id": group['type_id'],
        };
      }).toList();

      for (var group in groupsID) {
        var id = group['id'];
        var infoResponse1 = await http.get(
          Uri(scheme: 'https', host: host, path: '/api/groups/$id'),
        );
        Map<String, dynamic> groupInfo = {};
        if (infoResponse1.statusCode == 200) {
          final Map<String, dynamic> infoResponseData1 =
              json.decode(infoResponse1.body);
          final Map<String, dynamic> infoInfoData1 = infoResponseData1['data'];
          groupInfo.addAll({
            "id": id,
            "name": infoInfoData1['name'],
            "photo": infoInfoData1['photo']['url'],
          });
        } else {
          throw Exception(
              'API request failed with status ${infoResponse1.statusCode}');
        }

        var infoResponse2 = await http.get(
          Uri(scheme: 'https', host: host, path: '/api/groups/$id/member_list'),
        );

        if (infoResponse2.statusCode == 200) {
          final Map<String, dynamic> infoResponseData2 =
              json.decode(infoResponse2.body);
          final Map<String, dynamic> infoInfoData2 = infoResponseData2['data'];
          groupInfo["count"] = infoInfoData2['count'];
          groupsWithInfo.add(groupInfo);
        } else {
          throw Exception(
              'API request failed with status ${infoResponse2.statusCode}');
        }
      }

      return groupsWithInfo;
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}
