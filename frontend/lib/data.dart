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

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final path = p.join(dir.path, 'my_database.db');
    print(path);
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

  Future<void> cleanToken(Token data) async {
    final db = await initDatabase();
    await db.delete('sign_in_token');
  }
}
