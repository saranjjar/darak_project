// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper{
//   static Database? _db;
//   static const int _version = 1;
//   static const String _tableName = 'task';
//
//   static Future<void> initDB() async {
//     if(_db!=null) return;
//
//     try{
//       String _path = await getDatabasesPath() +'task.db';
//       _db = await openDatabase(
//           _path,
//           version: _version,
//           onCreate: (db,version){
//             if (kDebugMode) {
//               print('creating a new task');
//             }
//             return db.execute(
//                 "CREATE TABLE $_tableName("
//                     "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//                     "title STRING, note TEXT, date STRING,"
//                     "startTime STRING,endTime STRING,"
//                     "remind INTEGER,repeat STRING, "
//                     "color INTEGER,"
//                     "isCompleted INTEGER"
//                     ")"
//             );
//           }
//       );
//     }catch(error){
//       if(kDebugMode){
//         print(error.toString());
//       }
//     }
//   }
//
//   static Future<int> insertDB(Task? task) async {
//     if (kDebugMode) {
//       print('insert method called');
//     }
//     return await _db!.insert(_tableName, task!.toJson());
//   }
//
//   static Future<int> deleteDB(Task task) async{
//     return await _db!.delete(_tableName,where: 'id = ?',whereArgs:[task.id] );
//   }
//
//   static Future<List<Map<String,dynamic>>> query() async{
//     if (kDebugMode) {
//       print('query method called');
//     }
//     return await _db!.query(_tableName);
//   }
//
//
//   // static Future<List<Task>> getDB() async{
//   //   List<Task> task =[];
//   //   List<Map<String,dynamic>> tasks = await DatabaseHelper.query();
//   //   task.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
//   //   return task;
//   // }
// }