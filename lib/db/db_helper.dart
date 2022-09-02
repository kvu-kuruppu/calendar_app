import 'package:calendar_app/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:developer' as devtools show log;

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'Tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          devtools.log('Creating a new one');
          return db.execute(
            "CREATE TABLE $_tableName("
            "id	INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title	STRING, note	TEXT, date	STRING, "
            "startTime	STRING, endTime	STRING, "
            "remind	INTEGER, repeat	STRING, "
            "color	INTEGER, "
            "isCompleted	INTEGER)",
          );
        },
      );
    } catch (e) {
      devtools.log('Error:' + e.toString());
    }
  }

  static Future<int> insert(Task? task) async {
    devtools.log('Insert func called');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    devtools.log('Query func called');
    return await _db!.query(_tableName);
  }

  static Future<int> delete(Task task) async {
    return await _db!.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [task.id],
    );
  }
}
