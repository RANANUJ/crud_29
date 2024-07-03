import 'package:crud_29/todo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseProvider {
  static Database? database;
  var databaseName = "todoDatabase.db";
  DatabaseProvider() {
    createDatabase();
  }

  createDatabase() async {
    if (database == null) {
      if (kIsWeb) {
        var databaseFactory = databaseFactoryFfiWeb;
        database = await databaseFactory.openDatabase(
          databaseName,
          options: OpenDatabaseOptions(
              version: 1,
              onCreate: (db, int version) async {
                db.execute(
                    "CREATE TABLE TODO(id PRIMARY KEY AUTOINCREMENT INTEGER, title TEXT, description TEXT)");
              }),
        );
      } else {
        var path = join(await getDatabasesPath(), databaseName);
        //database = await openDatabase(path, version:1, oncreate:(db,version)){}................can also do like this for database
        var db = openDatabase(
          path,
          version: 1,
          onCreate: (db, version) {
            db.execute(
                "CREATE TABLE TODO(id PRIMARY KEY AUTOINCREMENT INTEGER, title TEXT, description TEXT)");
          },
        );
      }
    }
  }

  void insertTodo(TodoModel todoModel) {
    if (database != null) {
      database?.insert("todo", todoModel.toJson());
    }
  }
}
