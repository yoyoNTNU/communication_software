import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Token {
  final String authorization;
  Token({required this.authorization});
  Map<String, dynamic> toMap() {
    return {
      'authorization': authorization,
    };
  }
}

class SelfData {
  final int memberID;
  final String userID;
  final String name;
  final String photo;
  final String background;
  SelfData({
    required this.memberID,
    required this.userID,
    required this.name,
    required this.photo,
    required this.background,
  });
}

class FriendData {
  final int id;
  final String nickname;
  final String photo;
  final String introduction;
  FriendData({
    required this.id,
    required this.nickname,
    required this.photo,
    required this.introduction,
  });
}

class GroupData {
  final int id;
  final String name;
  final String photo;
  final int count;
  GroupData({
    required this.id,
    required this.name,
    required this.photo,
    required this.count,
  });
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final path = p.join(dir.path, 'my_database.db');
    //print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sign_in_token(
        authorization TEXT PRIMARY KEY
      )
    ''');
    await db.execute('''
      CREATE TABLE homepage_self_info(
        memberID INT PRIMARY KEY,
        userID TEXT,
        name TEXT,
        photo TEXT,
        background TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE homepage_friend_info(
        id INT PRIMARY KEY,
        nickname TEXT,
        photo TEXT,
        introduction TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE homepage_group_info(
        id INT PRIMARY KEY,
        name TEXT,
        photo TEXT,
        count INT
      )
    ''');
  }

  Future<void> setToken(Token data) async {
    final db = await initDatabase();
    await db.delete('sign_in_token');
    await db.insert('sign_in_token', data.toMap());
  }

  Future<Token?> getToken() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> results = await db.query('sign_in_token');
    if (results.isNotEmpty) {
      return Token(authorization: results[0]['authorization']);
    } else {
      return null;
    }
  }

  Future<void> clearToken() async {
    final db = await initDatabase();
    await db.delete('sign_in_token');
  }

  Future<void> cacheSelfData(Map<String, dynamic> selfData) async {
    final Database database = await initDatabase();
    await database.delete('homepage_self_info');
    await database.insert(
      'homepage_self_info',
      selfData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getCachedSelfData() async {
    final Database database = await initDatabase();
    final List<Map<String, dynamic>> maps = await database.query(
      'homepage_self_info',
    );

    if (maps.isNotEmpty) {
      return maps[0];
    } else {
      return null;
    }
  }

  Future<void> clearCache() async {
    final Database database = await initDatabase();
    await database.delete('homepage_self_info');
    await database.delete('homepage_friend_info');
    await database.delete('homepage_group_info');
  }

  Future<void> cacheFriendData(List<Map<String, dynamic>> friendData) async {
    final Database database = await initDatabase();
    await database.delete('homepage_friend_info');
    for (var friend in friendData) {
      await database.insert(
        'homepage_friend_info',
        friend,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCachedFriendData() async {
    final Database database = await initDatabase();
    final List<Map<String, dynamic>> maps = await database.query(
      'homepage_friend_info',
    );

    if (maps.isNotEmpty) {
      return maps;
    } else {
      return [
        {'empty': true}
      ];
    }
  }

  Future<void> cacheGroupData(List<Map<String, dynamic>> groupData) async {
    final Database database = await initDatabase();
    await database.delete('homepage_group_info');
    for (var group in groupData) {
      await database.insert(
        'homepage_group_info',
        group,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCachedGroupData() async {
    final Database database = await initDatabase();
    final List<Map<String, dynamic>> maps = await database.query(
      'homepage_group_info',
    );

    if (maps.isNotEmpty) {
      return maps;
    } else {
      return [
        {'empty': true}
      ];
    }
  }
}
