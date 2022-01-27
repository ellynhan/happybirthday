import 'package:gwanghoonmaker/model/collections.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DB{
  static const databaseName = "1.db";
  static Database? _database;

  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();

  Future<Database?> get database async {
    if (_database == null) return await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName), version: 1, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE collection (uid TEXT PRIMARY KEY NOT NULL, unlocked TEXT, easter TEXT)");
      await db.execute("INSERT INTO collection VALUES('1', '000000000000000000', '00000')");
    });
  }
}