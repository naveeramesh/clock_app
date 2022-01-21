// import 'package:flutter/cupertino.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:timer_app/models/alarm.dart';

// class DatabaseHelper extends ChangeNotifier {
//   List<Alarm> alarms_data = [];
//   //global initialization of table name,version
//   static final db_name = "alarm.db";
//   static final db_version = 1;

//   static final tablename = "Alarm_Table";

//   static final columnid = "id";
//   static final columnname = "title";
//   static final columndetail = "description";
//   static final columndatetime = "alarmdatetime";
//   static final columnactive = "isactive";

//   //checking the database if null create a new database

//   static Database? _database;
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     } else {
//       _database = await initializedatabase();
//     }
//     return _database!;
//   }

//   Future<Database> initializedatabase() async {
//     var dir = await getDatabasesPath();
//     var path = dir + db_name;

//     var database =
//         await openDatabase(path, version: db_version, onCreate: (db, version) {
//       //creating a table
//       db.execute('''
//        CREATE TABLE $tablename ( 
//           $columnid INTEGER PRIMARY KEY autoincrement, 
//           $columnname TEXT NOT NULL,
//           $columndatetime TEXT NOT NULL,
//           $columndetail TEXT NOT NULL,
//           $columnactive INTEGER)
//       ''');
//     });
//     return database;
//   }

//   Future<Alarm> insertAlarm(Alarm alarmInfo) async {
//     var db = await this.database;
//     Map<String, dynamic> row = {
//       columnid: alarmInfo.id,
//       columnname: alarmInfo.title,
//       columndetail: alarmInfo.description,
//       columnactive: alarmInfo.isactive,
//       columndatetime: alarmInfo.datatime.toIso8601String(),
//     };
//     final result = await db.insert(tablename, row);
//     // print(result);

//     return alarmInfo;
//   }

//   void print_table() async {
//     //How to print table
//     print("Ramesh");
//     var db = await this.database;
//     (await db.query(tablename, columns: [
//       columnid,
//       columndatetime,
//       columnactive,
//       columndetail,
//       columnname
//     ]))
//         .forEach((row) {
//       // print(row.values);
//     });
//   }

//   void delete_table() async {
//     //how to delete table
//     var db = await this.database;
//     await db.execute("DROP TABLE IF EXISTS $tablename");
//   }

//   getAlarm(Alarm alarm) async {
//     alarms_data.add(alarm);
//     print(alarms_data);
//     // var db = await this.database;
//     // var result = await db.query(tablename);
//     // print(result);
//     // result.forEach((element) {
//     //   // var alarminfo = Alarm.fromJson(element);
//     //   // print(element);
//     //   // print(element['title']);
//     //   alarms_data.add(Alarm(
//     //       id: 1,
//     //       isactive:1,
//     //       title: element['title'].toString(),
//     //       description: element['description'].toString(),
//     //       datatime: DateTime.now()));
//     // });
//     notifyListeners();
//   }
// }
// if (seconds != 0) {
              //   Timer.periodic(Duration(seconds: 1), (timer) {
              //     setState(() {
              //       if (seconds == 0 && min != 0) {
              //         seconds = 60;
              //       } else if (min == 0) {
              //         seconds = 0;
              //       } else {
              //         seconds--;
              //       }
              //     });
              //   });
              // }
              // if (min != 0) {
              //   Timer.periodic(Duration(minutes: 1), (timer) {
              //     setState(() {
              //       if (min == 0 && hour != 0) {
              //         min = 60;
              //       } else if (hour == 0) {
              //         min == 0;
              //       } else {
              //         min--;
              //       }
              //     });
              //   });
              // }
              // if (hour != 0) {
              //   Timer.periodic(Duration(hours: 1), (timer) {
              //     setState(() {
              //       if (hour == 0) {
              //         hour = 0;
              //       } else {
              //         hour--;
              //       }
              //     });
              //   });
              // }
