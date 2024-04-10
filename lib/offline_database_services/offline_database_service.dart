import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:public_housing/offline_database_services/model/offline_database_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
//  DatabaseProvider._();

//  static final DatabaseProvider db = DatabaseProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'bookmark.db');
    final exist = await databaseExists(path);
    if (exist) {
      final Future<Database> database = getDatabasesPath().then((String path) {
        return openDatabase(join(path, 'bookmark.db'));
      });
      return database;
    } else {
      return await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute('create table Bookmark ('
            'id integer primary key autoincrement,'
            'title text,'
            'description text,'
            'newsLink text,'
            'category text,'
            'footerTitle text'
            ')');
      });
    }
  }

  addToDatabase(OfflineDatabaseModel databaseModel) async {
    final db = await database;
    var raw = await db!.insert('Bookmark', databaseModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return raw;
  }

  updateDatabase(OfflineDatabaseModel databaseModel) async {
    final db = await database;
    var response = await db!.update('Bookmark', databaseModel.toMap(),
        where: 'id = ?', whereArgs: [databaseModel.id]);
    return response;
  }

  Future<OfflineDatabaseModel?> getDatabaseModelWithId(int id) async {
    final db = await database;
    var response =
        await db!.query('Bookmark', where: 'id = ?', whereArgs: [id]);
    return response.isNotEmpty
        ? OfflineDatabaseModel.fromMap(response.first)
        : null;
  }

  Future<List<OfflineDatabaseModel>> getAllData() async {
    final db = await database;
    var response = await db!.query('Bookmark');
    List<OfflineDatabaseModel> list =
        response.map((c) => OfflineDatabaseModel.fromMap(c)).toList();
    return list;
  }

  deleteDatabase(int id) async {
    final db = await database;
    return db!.delete('Bookmark', where: 'id = ?', whereArgs: [id]);
  }

  deleteAllDatabase() async {
    final db = await database;
    db!.delete('Bookmark');
  }
}
