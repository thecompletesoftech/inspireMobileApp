import 'dart:developer';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:public_housing/Database/tablenamestring.dart';
import 'package:sqflite/sqflite.dart';
class Crud extends GetxController {

  createdatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'docs.db');
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE appinfo (id INTEGER PRIMARY KEY AUTOINCREMENT,appname TEXT, appversion TEXT)');
    });
    createtable();
  }

  createtable() async {
    var db = await openDatabase('docs.db');

    await db.execute(
        'CREATE TABLE ${TablenameString().ImageList} (id INTEGER PRIMARY KEY AUTOINCREMENT,imagename TEXT)');
   
   }



  truncateTabel() async {
    print("truncate table");
    var db = await openDatabase('docs.db');
    // When creating the db, create the table
    await db.execute('DROP TABLE IF EXISTS ${TablenameString().ImageList}');

}

  insertdata(tablename,data) async {
    print("-------Insert into table--------");
   
    fetchalltablename();
 
   
        var db = await openDatabase('docs.db');

 Map<String, dynamic> row = data;

    // do the insert and get the id of the inserted row
    int id = await db.insert(tablename, row);
   print("inserted id"+id.toString());
  }

  fetchtablerecord(tablename) async {
    print("Tablename" + tablename.toString());
    var database = await openDatabase('docs.db');
    var data = await database.rawQuery('select * FROM  ${tablename}');
    
    return data;
  }

  fetchtablerecord_with_condition(tablename, filedname, filedvalue) async {
    var database = await openDatabase('docs.db');
    var data = await database.rawQuery(
        'select * FROM  ${tablename}  WHERE ${filedname} = ?', [filedvalue]);
    return data;
  }

  fetchtablerecord_with_conditiontwo_where(
      tablename, filedname, filedname1, filedvalue, filedvalue1) async {
    var database = await openDatabase('docs.db');
    var data = await database.rawQuery(
        'select * FROM  ${tablename}  WHERE ${filedname} = ? and ${filedname1} =?',
        [filedvalue, filedvalue1]);
    return data;
  }

  fetchtablerecord_with_conditionwith(tablename, filedname, filedvalue) async {
    var database = await openDatabase('docs.db');
    var data = await database.rawQuery(
        'select count(*) as count FROM  ${tablename}  WHERE ${filedname} = ?',
        [filedvalue]);

    return data.first;
  }

  fetchalltablename() async {
    var database = await openDatabase('docs.db');
    final tables =
        await database.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    log("data" + tables.toString());
  }
}
