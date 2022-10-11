import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class LocalDBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'tokopaedi.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE favorite_list (id TEXT PRIMARY KEY, name TEXT, price REAL, description TEXT, categories_id INTEGER, image_url TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> deleteTable(String table, List list) async {
    final db = await LocalDBHelper.database();
    await db.delete(table,
        where: 'id IN (${List.filled(list.length, '?').join(',')})',
        whereArgs: list);
  }

  static Future<void> insert(String table, dynamic data) async {
    final db = await LocalDBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> remove(String table, List<dynamic> id) async {
    final db = await LocalDBHelper.database();
    await db.delete(table, where: 'id = ?', whereArgs: id);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await LocalDBHelper.database();
    return db.query(table);
  }
}
