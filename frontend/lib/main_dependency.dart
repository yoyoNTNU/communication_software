import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:proj/data.dart';
import 'package:http/http.dart' as http;
import 'package:proj/main.dart';

Future<String?> initDatabaseAndGetToken() async {
  // 初始化数据库
  databaseFactoryOrNull = null;
  databaseFactory = databaseFactoryFfi;
  sqfliteFfiInit();

  // 从数据库中获取令牌
  final token = await DatabaseHelper.instance.getToken();
  return token?.authorization;
}

Future<bool> verifyToken(String? token) async {
  if (token == null) {
    return false; // 令牌不存在，无效
  }

  // 调用 API 验证令牌
  final response = await http.get(
    Uri(scheme: 'https', host: host, path: '/api/member/info'),
    headers: {'Authorization': token},
  );

  if (response.statusCode == 200) {
    return true; // 令牌有效
  } else {
    return false; // 令牌无效
  }
}
