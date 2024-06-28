import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'login_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      username TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('users', row);
  }

  Future<Map?> getUser(String username, String password) async {
    Database db = await instance.database;
    List<Map> results = await db.query('users',
        where: 'username = ? AND password = ?', whereArgs: [username, password]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<Map?> getUserByUsername(String username) async {
    Database db = await instance.database;
    List<Map> results = await db.query('users',
        where: 'username = ?', whereArgs: [username]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
}
