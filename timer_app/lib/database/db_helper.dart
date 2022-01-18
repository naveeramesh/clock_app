import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //global initialization of table name,version
  static final db_name = "alarm.db";
  static final db_version = 1;

  static final tablename = "Alarm Table";
  static final columnid = "id";
  static final columnname = "title";
  static final columndetail = "description";
  static final columndatetime = "alarmdatetime";
  static final columnactive = "isactive";

//creating a pro=ivate constructor for the class DatabaseHelper

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //checking the datavase if null create a new database

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initializedatabase();
    }
    return _database!;
  }

  Future<Database> initializedatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + db_name;

    var database =
        await openDatabase(path, version: db_version, onCreate: (db, version) {
      //creating a table
      db.execute('''
      CREATE TABLE $tablename
      $columnid integer primary key autoincrement,
      $columnname text NOT NULL,
      $columndatetime text NOT NULL,
      $columndetail integer,
          ''');
    });
    return database;
  }
}
