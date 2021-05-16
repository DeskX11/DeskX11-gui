import 'dart:async';
import '../models/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'test30';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => {
        await db.execute(
            "CREATE TABLE machine_list (id INTEGER PRIMARY KEY NOT NULL, compression STRING, password STRING, encryption STRING, port INTEGER, cmd STRING, ip STRING, name STRING, pic STRING)"),
        await db.execute(
            "CREATE TABLE settings (id INTEGER PRIMARY KEY NOT NULL, resolutionX INTEGER, resolutionY INTEGER, key STRING)"),
        await db.execute("INSERT INTO settings VALUES (0, 1920, 1080, 'ESC')")
      };

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  static Future<List<Map<String, dynamic>>> queryById(
          String table, int id) async =>
      _db.query(table, where: 'id = ' + id.toString());

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}
